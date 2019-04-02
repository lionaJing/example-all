/**
 *
 * @author Shuai.Jing
 * @date 2019/3/27
 */

//disconnect()
login('admin')
//connect()

var ws
function connect() {
    var socket = new SockJS('http://localhost:8080/lemon')
    ws = Stomp.over(socket)

    var headers = {
        username: 'admin',
        login: 'admin',
        passcode: 'admin123'
    }
    ws.connect(headers, function (frame) {

        ws.subscribe("/user/errors", function (message) {
            console.log("Error " + message.body)
        });

        ws.subscribe("/getMessage/test", function (message) {
            console.log(typeof message)
            console.log(message)
            console.log(JSON.stringify(message))
            console.log("广播推送接收 " + message.body)
        })

        ws.subscribe("/user/getResource", function (message) {
            console.log("精准推送接收A " + message.body)
        })

        ws.subscribe("/getResource", function (message) {
            console.log("精准推送接收B " + message.body)
        })

        ///user/admin/queue/say
        ws.subscribe("/user/queue/reply", function (message) {
            console.log("1监听指定用户 " + message.body)
        })

        ws.heartbeat.outgoing = 20000
        ws.heartbeat.incoming = 0

    }, function (error) {
        console.log("STOMP error " + error)
    })
}

function disconnect() {
    if (ws != null) {
        ws.disconnect()
    }
    console.log("Disconnected")
}

/**
 * 精准推送
 */
document.getElementById("ws").onclick = function () {
    console.log('精准推送')
    //参数1：消息的发送目的地
    //参数2：一个头信息的Map，它会包含在 STOMP 帧中
    //参数3：要发送的消息
    var json = JSON.stringify({'from': 'apple', 'message': '我是一条靳准江河湖海'})
    ws.send("/chat/toOne", {}, json);
}

/**
 * 广播推送
 */
document.getElementById("ws1").onclick = function () {
    console.log('广播推送')
    var json = JSON.stringify({'from': 'hi', 'message': '你收到了吗？'})
    ws.send("/chat/toAll", {'name': 'Lee', "id": 'id_09783431'}, json);
}
// 推送指定用户
document.getElementById("ws2").onclick = function () {
    console.log('推送指定用户')
    var json = JSON.stringify({'from': 'hi', 'message': 'hi!007_'})
    ws.send("/chat/to/userA", {"name": 'Lee', 'pwd': 'p_121','message-id':'test-01234'}, json);
}

function login(_name) {
    $.ajax({
        url: "http://localhost:8080/login",
        type: 'GET',
        data: {
            name: _name
        },
        success:function (data) {
            console.log(data)
            connect()
        },
        error:function () {
            console.log('login error')
        }
    })
}