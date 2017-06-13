![image](https://github.com/wangrui460/WRNavigationBar/raw/master/screenshots/WRNavigationBar.png)

# WRNavigationBar_swift

[OC 版本](https://github.com/wangrui460/WRNavigationBar)

------------------------------------------------------------

#### 1. 要实现以下这些效果都非常简单
![不同app的个人中心界面](https://github.com/wangrui460/WRNavigationBar_swift/raw/master/screenshots/apps.png)


#### 2. 废话不多说，先看看实现效果
![静态效果图](https://github.com/wangrui460/WRNavigationBar_swift/raw/master/screenshots/效果图.png)


#### 3. 下面告诉你我为什么说实现这些效果非常简单

比如说要实现蚂蚁森林的导航栏效果(有以下几个需求)：
- 刚进入导航栏透明、两边按钮和文字都是白色、状态栏也是白色
- 向上滚动后导航栏背景由透明逐渐变成白色
- 当超过某一点后，标题变成**黑色**、状态栏变成**黑色**、两边按钮变成**蓝色**

--- 

实现步骤：

1 . 实现刚进入导航栏透明、两边按钮和文字都是白色、状态栏也是白色
<pre><code>
override func viewDidLoad()
{
    super.viewDidLoad()
    // 设置导航栏颜色为白色        
    navBarBarTintColor = .white
    // 设置刚进入页面时透明度为0
    navBarBackgroundAlpha = 0
}
</code></pre>


2 .  实现剩下两个需求
<pre><code>
func scrollViewDidScroll(_ scrollView: UIScrollView)
{
    let offsetY = scrollView.contentOffset.y
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
        // 向上滚动后导航栏背景由透明逐渐变成白色
        navBarBackgroundAlpha = alpha
        if (alpha > 0.5) {
            // 当超过某一点后，两边按钮变成蓝色
            navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
            // 标题变成黑色
            navBarTitleColor = .black
            // 状态栏变成黑色
            statusBarStyle = .default
        } else {
            // 当没有超过某点，上面属性还原
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .lightContent
        }
    }
    else
    {
        navBarBackgroundAlpha = 0
        navBarTintColor = .white
        navBarTitleColor = .white
        statusBarStyle = .lightContent
    }
}
</code></pre>

3 . 发现没有，改变相关属性只要一句代码就完全搞定了！！！
<pre><code>
// 一行代码搞定导航栏颜色
navBarBarTintColor = .white
// 一行代码搞定导航栏透明度
navBarBackgroundAlpha = alpha
// 一行代码搞定导航栏两边按钮颜色
navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
// 一行代码搞定导航栏上标题颜色
navBarTitleColor = .black
// 一行代码搞定状态栏是 default 还是 lightContent
statusBarStyle = .default
</code></pre>

4 . 说了这么多，看看几句代码能否实现我们需要的效果吧
![image](https://github.com/wangrui460/WRNavigationBar_swift/raw/master/screenshots/mysl.gif)

5 . 有人可能会问：这只是在一个界面里面，但是涉及到push、pop、右滑手势怎么办呢？
答：没关闭，我已经给你处理好了，你不用写一句代码！！！那么看看效果吧
![image](https://github.com/wangrui460/WRNavigationBar_swift/raw/master/screenshots/mysl滑动.gif)




## 1️⃣. Installation 安装

> **手动拖入**
> 将 WRNavigationBar 文件夹拽入项目中，即可直接使用

## 2️⃣. How To Use 使用
<pre><code>
// 一行代码搞定导航栏颜色
navBarBarTintColor = .white
// 一行代码搞定导航栏透明度
navBarBackgroundAlpha = alpha
// 一行代码搞定导航栏两边按钮颜色
navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
// 一行代码搞定导航栏上标题颜色
navBarTitleColor = .black
// 一行代码搞定状态栏是 default 还是 lightContent
statusBarStyle = .default
</code></pre>


## 3️⃣. More 更多 

If you find a bug, please create a issue.  
Welcome to pull requests.  
More infomation please view code.  
如果你发现了bug，请提一个issue。  
欢迎给我提pull requests。  
更多信息详见代码，也可查看我的简书: [我的简书](http://www.jianshu.com/p/540a7e6f7b40)

## 4️⃣. Update 最近更新 

- **2017.05.12**
解决问题：侧滑一点松开透明的导航栏会变不透明

- **2017.05.16**
新增Demo：完成自定义导航栏实现透明渐变等效果

- **2017.05.20**
解决问题：解决侧滑返回导航栏没有渐变动画太突兀的问题

- **2017.05.21**
解决问题：解决push导航栏没有渐变动画太突兀的问题


## 5️⃣. 待完成功能


## 6️⃣. 期待

如果在使用过程中遇到BUG，或发现功能不够用，希望你能Issues我，或者加我的qq：1204607318
### 你觉得对你有所帮助的话，请献上宝贵的Star！！！ 不胜感激！！！

