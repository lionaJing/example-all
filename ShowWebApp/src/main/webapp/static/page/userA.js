/**
 *
 * @author Shuai.Jing
 * @date 2019/3/29
 */
var divConnectTip = $('#connectMsgId')
var text = $('#textId')
var progress = $('#progressId')
var uLeft = $('#listLId')
var uRight = $('#listRId')
var liLeft = $('<li class="list-group-item list-group-item-success"></li>')
var liRight = $('<li class="list-group-item list-group-item-primary"></li>')

var client
function connect() {
    console.log('开始建立连接...')
    var socket = new SockJS('http://localhost:8080/lemon') //lemon
    client = Stomp.over(socket)
    var headers={
        username:'userA',
        login:'userA',
        passcode:'userA123',
        'client-id': 'userA'
    }
    client.connect(headers, connectCallback,errorCallback)
}

connectCallback = function Callback1(frame) {
    divConnectTip.text('连接成功')
    $('#myModal').modal()

    client.subscribe("/user/errors", function(message) {
        console.log("Error " + message.body)
    });

    client.subscribe("/user/getResource", function(message) {
        console.log("接收服务端资源 " + message.body)
        liRight.text(message.body)
        var mLi = liRight.clone(true)
        uRight.append(mLi)
    })

    client.subscribe("/user/queue/reply", function(message) {
        console.log("推送消息: " + message.body)
        liRight.text('推送: '+message.body)
        var mLi = liRight.clone(true)
        uRight.append(mLi)
    })

    client.subscribe("/getMessage/test", function(message) {
        console.log(JSON.stringify(message))
        console.log("广播推送接收: " + message.body)
        liRight.text("广播:"+message.body)
        var mLi = liRight.clone(true)
        uRight.append(mLi)
    })

    client.subscribe("/user/control/do", function(message) {
        doSomething(message)
        console.log('----谁要控制我----')
    })
}
errorCallback = function errorCallback2(error) {
    divConnectTip.text('连接错误')
    $('#myModal').modal()
}

login('userA')
//connect()


// 获取服务端资源
$('#btnResId').click(function () {
    var json = JSON.stringify({'from':'UserA','message':'Get Server Resource'})
    client.send("/chat/toOne",{},json)
    liLeft.text("Resource GET")
    var mLi = liLeft.clone(true)
    uLeft.append(mLi)
})

// 推送到用户 B
$('#btnId').click(function () {
    if (isEmpty()) {
        $('#myModal').modal()
    }
    var json = JSON.stringify({'from':'apple','message':text.val()})
    client.send("/chat/to/userB",{},json)
    liLeft.text("to userB: "+text.val())
    var mLi = liLeft.clone(true)
    uLeft.append(mLi)
})

// 控制 ？
function doSomething(message) {
    $('#btnDoId').click(function () {
        alert(message)
    })
}

function isEmpty() {
    divConnectTip.text('消息不能为空')
    return text.val() == '' || text.val().length === 0
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
