【欢迎使用Secken开放平台iOS SDK产品！】

 在开发或者使用过程中，遇到问题或者疑问，请及时联系洋葱团队，我们都将竭尽全力解决。
 电话：010-64772882
 QQ群：154697540
 邮箱： support@secken.com


————————————————————V1.0.12——————————————————————————
【升级说明】

1，更新了钥匙串的问题。
2，更新了当有错误（或者失败）显示Log不详细的问题。
3，在bind接口，调用成功以后，不在返回Reg_ID  而是返回 
   hasFace(是否存在人脸，值为0和1) 
   hasVoice(声音是否训练成功，值为0和1)
   hasRegID(是否存在声音，值为0和1)

4，更新了部分Demo中的代码

5，在声音识别的时候添加了一个BOOL，表示是否在验证以后弹出AlertView。请参考Demo



————————————————————V1.0.11——————————————————————————
【升级说明】

1，修复了人脸训练（或者验证）的方法没有回调的问题。

————————————————————V1.0.10——————————————————————————
【升级说明】

1，修复了语音训练第一次（或者第二次）成功以后，会重复返回第一次（或者第二次）的问题。

————————————————————V1.0.9——————————————————————————
【升级说明】

1，修复了资源文件的使用，通过加载bundle文件来使用

2，修改了文档里导入SDK的部分内容

————————————————————V1.0.8——————————————————————————
【升级说明】

1，修复了使用系统NSString一个方法导致在iOS7系统上会闪退的问题。


————————————————————V1.0.7——————————————————————————
【升级说明】

1，修复了初始化SDK提示没有AppKey AppID的问题。


————————————————————V1.0.6——————————————————————————
【升级说明】

1，修复了SDK中的线程安全的问题。


————————————————————V1.0.5——————————————————————————
【升级说明】

1，在UI SDK当中添加了一个属性（布尔值），用来表示是否弹到上个页面。

2，修复了声音训练的Bug

3，优化了注册SDK以后，通过调用[SeckenSDK currSeckenSDK]，提示请初始化AppID AppKEY的问题

————————————————————V1.0.4——————————————————————————
【升级说明】

1，修改了说明文档的内容，添加了从官网申请APP ID和APP KEY的图片教程

2，修复了授权接口和声音接口以及人脸接口，通过返回hasFace或者hasVoice来判断是否存在人脸和声音



————————————————————V1.0.3——————————————————————————
【升级说明】

1，修改了AFNetwork引起冲突的问题。

2，修改了用户名使用符号如：@.com和_(下划线)导致提示未知错误的问题。 



————————————————————V1.0.2——————————————————————————
【升级说明】

1，修改了人脸训练Block每次都会回调的问题

2，修复了部分页面Pop的问题。






————————————————————V1.0.1----------------------------------------------------
【升级说明】

1，修改了说明文档部分的内容。

2，修复了SeckenSDK授权时的问题。




