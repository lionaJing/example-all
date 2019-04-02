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
    var socket = new SockJS('/lemon')
    client = Stomp.over(socket)
    var headers={
        username:'userB',
        login:'userB',
        passcode:'userB123',
        'client-id': 'userB'
    };
    client.connect(headers, connectCallback,errorCallback)
}

connectCallback = function Callback1(frame) {
    divConnectTip.text('连接成功')
    $('#myModal').modal()

    client.subscribe("/user/errors", function(message) {
        console.log("Error " + message.body)
        divConnectTip.text('发生异常:'+message.body)
        $('#myModal').modal()
    })

    client.subscribe("/user/getResource", function(message) {
        liRight.text(message.body)
        var mLi = liRight.clone(true)
        uRight.append(mLi)
    })

    client.subscribe("/user/queue/reply", function(message) {
        liRight.text(message.body)
        var mLi = liRight.clone(true)
        uRight.append(mLi)
    })

    client.subscribe("/getMessage/test", function(message) {
        liRight.text("广播:"+message.body)
        var mLi = liRight.clone(true)
        uRight.append(mLi)
    })
}
errorCallback = function errorCallback2(error) {
    divConnectTip.text('连接错误')
    $('#myModal').modal()
}

login('userB')

// 推送到用户 A
$('#btnId').click(function () {
    if (isEmpty()) {
        $('#myModal').modal()
    }
    var json = JSON.stringify({'from':'Jack','message':text.val()})
    client.send("/chat/to/userA",{},json);
    liLeft.text("to userA: "+text.val())
    var mLi = liLeft.clone(true)
    uLeft.append(mLi)
})

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
