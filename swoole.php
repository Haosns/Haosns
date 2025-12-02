<?php

declare(strict_types=1);

use think\App;

// 引入 ThinkPHP 的入口文件
// require __DIR__ . '/thinkphp/base.php';
require __DIR__ . '/vendor/autoload.php';
// 执行HTTP应用并响应
$http = (new App())->http;
$response = $http->run();
// $response->send();
// $http->end($response);


use think\facade\Log;
use app\common\enum\ChatMsgEnum;

class SwooleChatServer
{
    private $server;

    private $cache;

    private $prefix;

    private $port;

    private $redis = [
        'create_time'=>0,
        'obj'=>null,
    ];


    public function __construct($host = '0.0.0.0', $port = 9502)
    {
        try {
            // 创建 WebSocket 服务器
            $this->server = new \Swoole\WebSocket\Server($host, $port,SWOOLE_PROCESS, SWOOLE_SOCK_TCP | SWOOLE_SSL);
            //配置参数
            $this->server->set([
                'daemonize' => false, //守护进程化。
                //配置SSL证书和密钥路径
                'ssl_cert_file' => "/www/server/panel/vhost/ssl/demo.haosns.com/fullchain.pem",
                'ssl_key_file'  => "/www/server/panel/vhost/ssl/demo.haosns.com/privkey.pem"
            ]);
            // $this->cache = new \app\common\cache\ChatCache();
            $this->prefix = config('project.websocket_prefix');
            $this->$port = $port;
        } catch (\Throwable $e) {
            Log::write('建立连接错误--'. $e->getMessage());
        }

        // 注册事件回调
        $this->server->on('open', [$this, 'onOpen']);
        $this->server->on('message', [$this, 'onMessage']);
        $this->server->on('close', [$this, 'onClose']);

        // HTTP 请求处理
        $this->server->on('request', [$this, 'requestMessage']);
    }

    public function requestMessage(Swoole\Http\Request $request, Swoole\Http\Response $response)
    {

        if(\think\facade\Request::ip() == '0.0.0.0'){
            $params = $request->post;
            if($params['type'] == 'private_chat'){
                echo '私聊消息';
                $toFds = $this->getFdByUid($params['to_id']);
                print_r($toFds);
                if($toFds  && !empty($toFds)){
                    return $this->pushData($toFds, 'chat', $params);
                }else{
                    echo '没有在线,to_id：'.$params['to_id'];
                }
            }elseif($params['type'] == 'group_chat'){
                echo '群聊消息';
                // 获取群下的所有成员
                $groupMember = \app\common\model\ChatGroupMember::where([
                    ['group_id','=',$params['group_id']],
                    ['user_id','!=',$params['from_id']],
                ])->where('status',1)->select()->toArray();
                $toFds = [];
                // 通过群成员id找到每个成员的fd
                foreach($groupMember as $v){
                    $fds = $this->getFdByUid($v['user_id']);
                    $toFds[] =  $fds;
                }
                foreach($toFds as $toFd){
                    $this->pushData($toFd, 'chat', $params);
                }
            }elseif($params['type'] == 'circle_chat'){
                echo '圈子消息';
                // 获取群下的所有成员
                $circleMember = \app\common\model\ChatTemp::where([
                    ['circle_id','=',$params['circle_id']],
                    ['user_id','!=',$params['from_id']],
                ])->select()->toArray();
                $toFds = [];
                // 通过群成员id找到每个成员的fd
                foreach($circleMember as $v){
                    $fds = $this->getFdByUid($v['user_id']);
                    $toFds[] =  $fds;
                }
                foreach($toFds as $toFd){
                    $this->pushData($toFd, 'chat', $params);
                }
            }elseif($params['type'] == 'kefu_chat'){
                if($params['from'] == 'kefu'){
                    echo '客服给用户发消息';
                    $toFds = $this->getFdByUid($params['user_id'],$type="user");
                }elseif($params['from'] == 'user'){
                    echo '用户给客服发消息';
                    $toFds = $this->getFdByUid($params['kefu_id'],$type="kefu");
                }

                print_r($toFds);
                if($toFds  && !empty($toFds)){
                    return $this->pushData($toFds, 'chat', $params);
                }else{
                    echo '没有在线：';
                }
            }elseif($params['type'] == 'notice'){
                echo '通知消息';
                $toFds = $this->getFdByUid($params['to_id']);
                print_r($toFds);
                if($toFds  && !empty($toFds)){
                    return $this->pushData($toFds, 'notice', $params);
                }else{
                    echo '没有在线,to_id：'.$params['to_id'];
                }
            }
        }else{
            echo '非本地服务器，不能访问:'.\think\facade\Request::ip();
        }


    }

    public function getRedis()
    {

        if($this->redis['obj']){
            echo 'redis对象创建时间：'.date('Y-m-d H:i',$this->redis['create_time']);
            return $this->redis['obj'];
        }
        // 创建 Redis 实例
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $this->redis['obj'] = $redis;
        $this->redis['create_time'] = time();

        return $this->redis['obj'];
    }

    public function start()
    {
        // $this->getRedis()->flushAll();
        echo "Swoole WebSocket Server started at ws://0.0.0.0:".$this->port."\n";
        $this->server->start();
    }

    public function onOpen(Swoole\WebSocket\Server $server, Swoole\Http\Request $request)
    {
        echo "onOpen\n";
        $token = $request->get['token'];
        $type = $request->get['type']??'user';
        $fd = $request->fd;
        try {
            $user = $this->triggerEvent('login', ['token' => $token,'type'=>$type]);
            // if ($user['code'] == 20001 || empty($user['data']['id'])) {
            //     throw new \Exception(empty($user['msg']) ? "未知错误" : $user['msg']);
            // }
            if ($user['code'] == 20001) {
                throw new \Exception(empty($user['msg']) ? "未知错误" : $user['msg']);
            }
        } catch (\Throwable $e) {
            echo 'onOpen失败--'. $e->getMessage();
            return $this->server->close($fd);
        }

        $this->bindFd($user['data'], $fd,$type);
        return $this->pushData($fd, 'login', [
            'msg' => '连接成功',
            'msg_type' => ChatMsgEnum::TYPE_TEXT,
            'clinet_id'=>$fd,
        ]);
    }

    public function onMessage(Swoole\WebSocket\Server $server, Swoole\WebSocket\Frame $frame)
    {
        echo "onMessage\n";

        try {
            echo "\n 接收到了ping消息 {$frame->fd} \n";

            $params = json_decode($frame->data,true);

            if($params['event'] != 'ping'){
                return;
            }

            // 检测当前客户端id是否登录缓存存在，不存在则断开你的链接
            // 通过fd获取用户信息，通过用户id获取所有fd，删除其他多余的fd;
            $user = $this->getDataByFd($frame->fd);
            if(!is_array($user)){
                echo "未登录断开连接\n";
                $this->pushData($frame->fd, 'error', [
                    'msg' =>"未登录断开连接,请重连f{$frame->fd}--".$user
                ]);

                // 重新绑定

                return;
            }

            // 用户最近一次在线时间和浏览页面
            $user_online_data = [
                'time'=>time(),
                'path'=>$params['data']['path'],
                'user'=>$user,
            ];
            $this->getRedis()->set('user_online_'.$user['uid'], json_encode($user_online_data));


            // 已连接 通过uid 查询到旗下的所有fd,断开连接其他设备
            $user_fd_list = $this->getFdByUid($user['uid']);


            if(is_array($user_fd_list)){
                if(!in_array($frame->fd,$user_fd_list)){
                    $this->pushData($frame->fd, 'error', [
                        'msg' =>'fd里没有你当前设备的fd'
                    ]);

                    // 重新绑定
                }
            }else{
                echo "无任何fd记录\n";
                $this->pushData($frame->fd, 'error', [
                    'msg' =>'无fd记录,请重连2'
                ]);
                // 重新绑定
            }
        } catch (\Throwable $e) {
            echo 'onMessage错误--'. $e->getMessage();
            return $this->pushData($frame->fd, 'error', [
                'msg' =>'onMessage错误:'.$e->getMessage()
            ]);
        }


    }

    public function onClose(Swoole\WebSocket\Server $server, $fd)
    {
        echo "Connection close: {$fd}\n";
        // $this->triggerEvent('close', ['handle' => $this, 'fd' => $fd]);
        $this->removeBind($fd);
        $this->server->close($fd);
    }

    /**
     * @notes 触发事件
     * @param string $event
     * @param array $data
     * @return mixed
     */
    public function triggerEvent(string $event, array $data)
    {
        $res = \think\facade\Event::trigger('swoole.websocket.' . $event, $data);
        return $res[0];
    }

    /**
     * @notes 移除当前窗口的fd绑定
     * @param $fd
     */
    public function removeBind($fd,$type='user')
    {

        $data = $this->getDataByFd($fd);
        if (is_array($data)) {
            print_r($data);
            echo '删除用户id下的某个fd';
            $key = $this->prefix .  $data['type']. '_' . $data['uid'];
            echo 'key:'.$key;
            $this->getRedis()->sRem($key, $fd); // socket_user_uid => fd
        }
        // 删除fd对应的用户信息
        $this->getRedis()->del($this->prefix . 'fd_' . $fd);
    }

    /**
     * @notes 登录者的id绑定fd
     * @param $type
     * @param $user
     * @param $fd
     */
    public function bindFd($user, $fd,$type='user')
    {
        $uid = $user['id'];

        //== 缓存 fd 对应 用户信息
        $fdKey = $this->prefix . 'fd_' . $fd;
        $fdData = [
            'uid' => $uid,
            'nickname' => $user['nickname']??'',
            'avatar' => $user['avatar'],
            'token' => $user['token'],
            'type'=>$type,
        ];
        $this->getRedis()->set($fdKey, json_encode($fdData));

        //== 缓存 uid 对应 所有fd
        $uidKey = $this->prefix .$type.'_'. $uid;
        $this->getRedis()->sadd($uidKey, $fd);
    }

    /**
     * @notes 通过登录id和登录类型获取对应的fd
     * @param $uid
     * @param $type
     * @return bool
     */
    public function getFdByUid($uid,$type='user')
    {
        $key = $this->prefix . $type.'_' . $uid;
        echo '根据uid:'.$key.'获取用户信息:';
        $result = $this->getRedis()->sMembers($key);
        print_r($result);
        echo 'end';
        return $result;
    }


    /**
     * @notes 推送数据
     * @param $fd
     * @param $event
     * @param $data
     * @return bool
     */
    public function pushData($fd, $event, $data)
    {
        $data = $this->encode($event, $data);
        // fd非数组时转为数组
        if (!is_array($fd)) {
            $fd = [$fd];
        }
        $fd = array_unique($fd);
        echo '发送消息了';
        print_r($fd);
        // 向fd发送消息
        foreach ($fd as $item) {
            echo '向fd发送消息';
            print_r($item);
            echo '-end';
            $item = intval($item);
            try{
                if ($this->server->exist($item)) {
                    $this->server->push($item, $data);
                }
            }catch(\Exception $e){
                echo "\n推送消息失败:".$e->getMessage()."\n";
            }
        }
        return true;
    }

    /**
     * @notes 根据fd获取登录的id和登录类型
     * @param $fd
     * @return mixed|string
     */
    public function getDataByFd($fd)
    {
        $key = $this->prefix . 'fd_' . $fd;
        echo '根据fd获取登录的id和登录类型';
        echo $key;
        echo '-end';
        $result = $this->getRedis()->get($key);
        if (!empty($result)) {
            $result = json_decode($result, true);
        }else{
            echo "\n --------------getDataByFd为空----{$key}----------------------- \n";
            print_r($result);
        }
        return $result;
    }


    public function encode(string $event, $data)
    {
        return json_encode(['event' => $event, 'data' => $data]);
    }

    /**
     * @notes json转数组数据
     * @param $data
     * @return array
     */
    public function decode($data)
    {
        $result = json_decode($data, true);
        return [
            'event' => $result['event'] ?? null,
            'data' => $result['data'] ?? null,
        ];
    }

}


$chatServer = new SwooleChatServer();
$chatServer->start();