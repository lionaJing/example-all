/**
 *
 * @author Shuai.Jing
 * @date 2019/3/29
 */
var text = $('#textId')

// 控制用户 A
$('#btnAId').click(function () {
    var str = text.val()
    doHttp('userA',str === '' ? '默认消息': str)
})

// 发送广播
$('#btnAllId').click(function () {
    var str = text.val()
    doHttp('all',str === '' ? '默认消息 All': str)
})

function doHttp(userName,str) {
    $.ajax({
        url: "http://localhost:8080/control",
        type: 'POST',
        data:{
            user: userName,
            message: str
        },
        success:function (data) {
            alert(data)
        },
        error:function () {
            alert('控制失败')
        }
    })
}