<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" 
    Inherits="UpdateHistory" Title="O'Mei - Update History" Codebehind="UpdateHistory.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        OmeiTravel修改记录</h1>
    <h2>
        ---待作修改(尚未完成)---</h2>
    <div>
        <ul>
            <li>Email回复客户；</li>
            <li>Email批量发送； </li>
            <li>Order的回复email</li>
            <li>报表:统计tours盈利情况排行</li></ul>
    </div>
    <p>
    </p>
    <h2>
        ---最新修改---</h2>
    <ul>
        <li>2009-03-20
            <ul>
                <li>项目中增加MVC模式；</li>
                <li>修改Invoice Match；</li>
                <li>新增Destination修改模式；</li>
                <li>增加Jquery脚本框架；</li>
            </ul>
        </li>
        <li>2008-06-18
            <ul>
                <li>新增Invoice Match列表页面；</li>
                <li>增加Invoice Match取消功能；</li>
                <li>修改Credit Voucher支持按各列排序显示；</li>
                <li>调整部分页面显示样式；</li>
            </ul>
        </li>
        <li>2008-05-05
            <ul>
                <li>新增Commission Rate設置和按月統計；</li>
                <li>修改toolbox樣式為自動適應高度；</li>
                <li>修改invoice match中出現的錯誤；</li>
                <li>重新定制credit voucher的打印格式；</li>
            </ul>
        </li>
        <li>2007-12-16
            <ul>
                <li>徹底修改Agent相關訂單操作流程，解決訂單cancel后不能與agent order同步的問題。主要修改包括：
                    <ul>
                        <li>order中修改agent recv和agent transfor從訂單修改中獨立出來，修改agent的同時回檢驗是否允許修改（當已經和agent進行支付或invoice
                            match后，將不能變更agent。</li>
                        <li>agent的訂單如不是客戶full pay，則須使用pay by agent用agent credit付清余額，超過該agent max crecit時不能完成，須先進行agent
                            payment 或 max credit。</li>
                        <li>打印agent recv清單時將未清算的全部order都打印出來。</li>
                        <li></li>
                    </ul>
                </li>
                <li>Agent增加max credit項，當order pay by agent時，如果該agent的訂單總額超過max credit將不能完成payment。</li>
                <li>增加Ticket類型列表與修改頁面；</li>
                <li>修改客戶選擇窗口，使用dhtmlgoodies.com的窗口控件；</li>
                <li>取消Schedule價格，全部價格使用Tours上設定的價格；</li>
                <li>Payment將Cash,Check,Credit Card,Credit Voucher,Agent多種支付方法合并再同一支付頁面；</li>
                <li>修改Credit Card支付流程和相關程序；</li>
                <li>修改信用卡保存頁面；</li>
                <li>付款人與參團人分開記錄；</li>
                <li>電話號碼自動分段；</li>
            </ul>
        </li>
        <li>2007-07-30
            <ul>
                <li>添加InvoiceID和相关数据表及程序；</li><li>修改Ticket打印页面；</li></ul>
        </li>
        <li>2007-07-15
            <ul>
                <li>Order中增加Operation log，详细显示修改记录；</li><li>修改Agent report中打印标题换行；</li><li>重新清理数据库中电话号码中的其他字符；</li><li>
                    调整ticket打印位置；</li></ul>
        </li>
        <li>2007-06-17
            <ul>
                <li>Agent Receivable修改为默认按Company Name排序，并可自选字段排序；</li><li>修改網站顯示機票頁面出錯（<a href="http://www.omeitravel.com/cn/Flights.aspx"
                    target="_blank">http://www.omeitravel.com/cn/Flights.aspx</a>）；</li><li>按照指定的agent invoice格式修改agent
                        invoice；</li><li>Ticket上面打印出by credit card / cash / check；</li><li>修改Order discount使能够按照配置显示出正确的折扣项目；</li></ul>
        </li>
        <li>2007-05-27</li><ul>
            <li>Order中显示业务员和时间</li><li>scheduleorder页面中加上balance和room share with；</li><li>HOLD的order修改客户名时会丢失座位；</li><li>
                agent invoice加上tel &amp; fax，修改标题换行；</li><li>Company &amp; Agent 查询出错；</li></ul>
        <li>2007-05-20
            <ul>
                <li>Order列表中增加Agent显示；</li><li>Agent中添加缩写名称，方便在其他列表中显示；</li><li>Sales Report默认修改为当天，并添加当月的按钮；</li></ul>
        </li>
        <li>2007-05-14
            <ul>
                <li>在Schedule页面中显示价格，方便调整；</li><li>新增Sales Report；</li><li>修改Agent Invoice；</li></ul>
        </li>
    </ul>
    <p>
    </p>
    <ul>
        <li>2007-05-03
            <ul>
                <li>
                网站上可显示Full schedule；
                <li>添加可修改价格的浮动价格订单；</li><li>新增Agent相关Payment查询；</li><li>修正schedule 客人及房间数量统计；</li></ul>
        </li>
    </ul>
    <ul>
        <li>2007-03-31
            <ul>
                <li>修改Flight功能</li></ul>
        </li>
        <li>2007-03-23
            <ul>
                <li>修改Destination中选择景点使用中英文;</li><li>修改DestinationID=0和tourID=0造成问题;</li><li>隐藏status为hide的tours;</li><li>
                    ScheduleList中显示subTitle;</li><li>修改orders查询;</li></ul>
        </li>
        <li>2007-03-20
            <ul>
                <li>修改Day and Nights的自动显示;</li><li>增加hold, sold, rooms的统计;</li><li>修改错误列表中列出的14个错误;</li></ul>
        </li>
        <li>2007-03-06
            <ul>
                <li>修改Agent invoice格式</li></ul>
        </li>
        <li>2007-03-01
            <ul>
                <li>修改Destinations添加Photo</li><li>修改添加新Customer</li><li>修改Pay by credit card,添加amount,service
                    fee</li></ul>
        </li>
        <li>2007-02-20
            <ul>
                <li>修改<a href="AgentReceivables.aspx">Agent Report</a></li><li>修改权限相关问题；</li></ul>
        </li>
        <li>2007-02-15
            <ul>
                <li>修改权限分配相关问题；</li></ul>
        </li>
        <li>2007-02-14
            <ul>
                <li>增加操作日志Log</li><li>上车地点可以自行增加，页面“<a href="TypeRef.aspx">Admin-list types</a>”</li><li>
                    座位的Release需要权限；</li><li>增加<a href="ReportDailyPayment.aspx">Daily Payment Report</a></li></ul>
        </li>
        <li>2007-01-24
            <ul>
                <li>增加用户搜索快捷输入框；</li><li>Agent修改Discount；</li></ul>
        </li>
        <li>2007-01-18
            <ul>
                <li>增加对list type的自定义颜色设定；</li><li>Bus tour report</li><li>自动进行每日数据备份（备份至d:\data\bak目录下）</li><li>
                    Agent支付</li><li>invoice match</li><li>修改页面在Post back后丢失title</li><li>Agent增加Discount设置</li><li>
                        统计报表－Bus Tour Summary； </li>
                <li>统计报表－Agent Summary；</li></ul>
        </li>
        <li>2006-12-24
            <ul>
                <li>Print ticket和order detail对notes长单词强制换行；</li><li>用户自行修改用户信息和密码页面； </li>
                <li>agent支付，包括代收处理；</li><li>可选择的不显示Canceled Schedules；</li><li>改正输入schedule的tour guide时，列表不完全；</li><li>
                    菜单中添加司机修改页面；</li></ul>
        </li>
        <li>2006-12-18
            <ul>
                <li>机票</li><li>酒店 </li>
                <li>显示room share with F/M； </li>
                <li>修改菜单和导航功能； </li>
                <li>增加ticket上的remark； </li>
            </ul>
        </li>
        <li>2006-12-07
            <ul>
                <li>订单修改；</li><li>座位表修改，更方便的取消和增加座位；</li></ul>
        </li>
        <li>2006-12-03
            <ul>
                <li>信用卡支付；</li><li>schedule标题加上day和subtitle；</li></ul>
        </li>
        <li>2006-11-27
            <ul>
                <li>通过电话号码快速查找客户（自动取消电话中的非数字字符）；</li><li>客户搜索和添加维护；</li><li>列表中的status换为对应说明文字；</li><li>
                    自动出团；</li></ul>
        </li>
        <li>2006-11-21
            <ul>
                <li>权限详细设置；</li><li>打印样式设置；</li><li>制作单独schedule取消页面；</li></ul>
        </li>
        <li>2006-11-19
            <ul>
                <li>修改employee维护相关页面：修改密码等；</li><li>登录后显示welcome xxx；</li></ul>
        </li>
        <li>2006-11-18
            <ul>
                <li>权限控制；</li><li>菜单按权限列出；</li><li>roles修改页面；</li></ul>
        </li>
        <li>2006-11-02
            <ul>
                <li>页面主框架改为用table排版，消除窗口缩小时错位； </li>
            </ul>
        </li>
        <li>2006-10-13
            <ul>
                <li>修改employee表结构，修改Login，修改对userId的引用为employeeID； </li>
                <li>导游，司机和巴士在指派后防止重复安排； </li>
                <li>菜单及页面权限管理调整； </li>
            </ul>
        </li>
        <li>2006-10-07
            <ul>
                <li>修改OrderList出现customername不能为null错误； </li>
                <li>添加tour作为单独菜单项； </li>
                <li>添加distination作为单独菜单项； </li>
            </ul>
        </li>
        <li>2006-10-06
            <ul>
                <li>批量打开与取消Schedules放置在Add schedule页面中； </li>
                <li>修改toolbox样式为标准框状； </li>
                <li>ticket上添加座位号； </li>
                <li>修改输入日期格式为：mm/dd/yyyy； </li>
            </ul>
        </li>
        <li>2006-10-05
            <ul>
                <li>调整Print ticket，添加ticket上的数据； </li>
                <li>调整PrintMaster，打印页面使用ScriptX客户端打印控件； </li>
            </ul>
        </li>
        <li>2006-09-30
            <ul>
                <li>打印order ticket； </li>
            </ul>
        </li>
        <li>2006-09-28
            <ul>
                <li>修改程序调整错误，设定导航条资料； </li>
                <li>重写schedule酒店控件，解决错误酒店列表问题； </li>
                <li>网站订单打印（另作打印页）; </li>
                <li>Tours.aspx界面修改，分列TourType； </li>
            </ul>
        </li>
        <li>2006-09-25
            <ul>
                <li>修改座位表不能显示相关订单； </li>
                <li>修改Vehicle样式错误； </li>
                <li>DataSelector增加可显示列表中项目数； </li>
            </ul>
        </li>
        <li>2006-09-24
            <ul>
                <li>在日程表中添加批量选择，进行Open和cancel操作； </li>
                <li>修改tour guide列表选择出错(ScheduleEdit.aspx)； </li>
                <li>重新设计主菜单体系；
                    <ul>
                        <li>1)修改为下拉菜单，操作更直接快捷； </li>
                        <li>2)修改所有页面的Master Page； </li>
                        <li>3)建立web.sitemap，实现导航条； </li>
                        <li>4)修改scheduleList.aspx，分开巴士团、Package等； </li>
                        <li>5)界面修饰； </li>
                    </ul>
                </li>
            </ul>
        </li>
        <li>2006-09-23
            <ul>
                <li>添加Order ID和Schedule ID快捷方式； </li>
                <li>修改网站（中文）不能显示景点小图( cn/destionation.aspx )； </li>
                <li>缩小座位表，打印时每格两行； </li>
            </ul>
        </li>
    </ul>
</asp:Content>
