
--***********函数区**********


function deskTop()--回到桌面
	pressHomeKey();
	mSleep(1000)
end

function openApp()--进入登录界面

	r = runApp("com.jp.activity")--启动APP
	mSleep(6000)
	touchDown(1, 70, 775)--选择“社管通”APN
	touchUp(1, 70, 775)
	mSleep(2600)
	os.execute("input keyevent 4") --返回键（因为要选择APN）
	mSleep(1000)
end

function rnd(max)--取随机数 产生 1-max 的整数
	--就是把 time返回的数值字串倒过来（低位变高位）， 再取高位6位。 
	--这样， 即使 time变化很小， 但是因为低位变了高位， 种子数值变化却很大，就可以使伪随机序列生成的更好一些
	--http://blog.csdn.net/zhangxaochen/article/details/8095007
  
  --lua的第1次random数不靠谱，取第3次的靠谱
  local ret=0
  math.randomseed(tostring(os.time()):reverse():sub(1, 6))
  for i=1,3 do
    n = math.random(max)
    ret=n
  end
  return ret
end


function readFile(path)--读取文件。很奇怪，第一行即使是正确的id也无法登陆，必须到第二行。难道第一行带有文件头标记？
    local file = io.open(path,"r");
    if file then
        local _list = {};
        for l in file:lines() do
            table.insert(_list,l)
        end
        file:close();
        return _list
    end
end

function Login(id,pw)--登录社管通
	
	touchDown(1, 841, 318)--光标定位至ID框
	touchUp(1, 841, 318)
	mSleep(500)
	
	for var = 1,9 do --清除原有ID
    --inputText("\b")
	mSleep(500)
	os.execute("input keyevent 67")
	end
	inputText(id)
	mSleep(500)
	
	touchDown(1, 841, 453)--光标定位至密码框
	touchUp(1, 841, 453)
	mSleep(500)
	for var = 1,13 do --清除原有密码
    --inputText("\b")
	mSleep(500)
	os.execute("input keyevent 67")
	end
    inputText(pw)
	mSleep(500)
	touchDown(1, 525, 734)--点击登录
	touchUp(1, 525, 734)
	mSleep(3000)
end

function work()--开始登录后的操作
touchDown(1,322,488)--信息采集
touchUp(1,322,488)
mSleep(200)

end

--**********数据区******************(数组访问的下标是从 1 开始的)
cun = {"袁家村","八府赵村","油坊王村","庵陈村","绰王村","打车李村","祥付营村"}--7个村

sec1 = {"在下村走访中发现，","走访的时候发现，","巡查的时候发现，","今天下村巡查时发现，",
	"今天下村时有群众反映，","下村的时候有人反映，","巡查的时候有人反映，","下村巡查时有人反映",
	"于今日走访中发现，","在今日巡查时发现，","本日巡查时发现，","本日下村的时候发现",
	"于今日走访的时候有群众反映，","在今日巡查时有人反映，","本日巡查时有群众反映，","本日下村时候有群众反映,",
	"今天驻村开展工作时发现，","本日在村里走访的时候发现，","今天下村开展工作时发现，","在今天入村走访时发现，",
	"今天在村里开展工作时有人反映，","本日在村里走访的时有群众说，","今天下村时有人反映说，","在今天入村走访时有人反映，"}


scjg = {"有无证摊贩占道经营，影响交通","有人销售假冒农药对群众种地带来隐患","有人销售三无小食品对食品安全带来风险",
	"有人在销售过期食品，带来食品安全银隐患","有小卖部卖过期食物，危害群众食品安全"}

jjyx = {"集贸市场设施损坏，影响群众卖农产品","收购玉米的商贩不给够称，缺斤短两",
	"保险公司的农业保险一直不来登记","红薯现在不好卖，应该寻找销售渠道","少数人粮食直补没有到账应该调查落实"}

ggfw = {"道路边上的路灯不亮影响群众出行","村文化活动中心不通电，群众没法开展活动","村头有垃圾堆积，影响环境应该尽快清理",
	"部分群众打工没门路，需要介绍职业","道路坑洼不平，影响群众出行应该尽快处理"}

shgl = {"菜市场秩序混乱，影响正常买卖","秸秆禁烧宣传力度不到位，有些群众还意识不到","退伍老兵生活比较艰难，要求提高待遇",
	"支边人员一直要求落实政策，有不稳定因素","部分村干部不作为，遇事不管，群众有意见"}

hjbh = {"村头有很多垃圾，影响环境应尽快清理","道路两边有很多秸秆堆积，存在安全风险","耕地内有很多农业垃圾，影响群众正常种地",
	"村里道路脏乱，环境较差，需要尽快清理","路沟里有很多垃圾，污染环境，需要尽快处理"}

xfaq = {"村里小超市存在电线私拉乱扯现象","饭店里的电线比较杂乱，有安全隐患","小超市没有配备灭火器",
	"馍店不注意用火安全，有安全隐患","大量的秸秆堆积，存在一定消防隐患"}
--***********************程序入口点*******************************
init(0);
mSleep(1000);
deskTop();
mSleep(100);
switchTSInputMethod(true);--切换到触动精灵输入法，用于自动输入

path  = getPath();--读取账户密码文件
idList = readFile(path.."/lua/sqid.txt");
pwList = readFile(path.."/lua/sqpw.txt");


for var = 1,20 do-------【此处开始循环发信息】------
mSleep(1500)
openApp();



loginx = rnd(4) + 1--随机选一个账户进行登录
mSleep(1530)--延时，给时间足够的跨度，以生成更随机的而数字
toast("4账户之"..tostring(loginx)); 
Login(idList[loginx],pwList[loginx]);





 
work();

cunx = rnd(7)--随机选一个村
toast("7村之"..tostring(cunx)); 
mSleep(1870)--延时，给时间足够的跨度，以生成更随机的而数字
a = rnd(6)--随机选一个事件
mSleep(1870)--延时，给时间足够的跨度，以生成更随机的而数字
--a = 6
toast("6类型之"..tostring(a)); 

if a == 1 then--【社会管理】
eventsx = rnd(5)
mSleep(1330)--延时，给时间足够的跨度，以生成更随机的而数字
inputText(cun[cunx]..scjg[eventsx])--输入事件标题
mSleep(200)
toast("5事件之"..tostring(eventsx));
--“市场监管”不用选择事件类别
touchDown(1,463,1280)--选择"问题地址"
touchUp(1,463,1280)
mSleep(200)
inputText(cun[cunx])--输入地址
mSleep(200)
touchDown(1,418,1451)--选择"问题描述"
touchUp(1,418,1451)
mSleep(200)
inputText(sec1[rnd(24)]..cun[cunx]..scjg[eventsx].."。")--输入问题描述


elseif a == 2 then--【经济运行】
--do()
eventsx = rnd(5)
mSleep(1330)--延时，给时间足够的跨度，以生成更随机的而数字
inputText(cun[cunx]..jjyx[eventsx])--输入事件标题
mSleep(200)
touchDown(1,387,480)--选择事件类别（尽量靠下，因为标题长了会往下移动）
touchUp(1,387,480)
mSleep(500)
touchDown(1,420,740)--选择"经济运行"
touchUp(1,420,740)
mSleep(1000)

touchDown(1,463,1280)--选择"问题地址"
touchUp(1,463,1280)
mSleep(200)
inputText(cun[cunx])--输入地址
mSleep(200)
touchDown(1,418,1451)--选择"问题描述"
touchUp(1,418,1451)
mSleep(200)
inputText(sec1[rnd(24)]..cun[cunx]..jjyx[eventsx].."。")--输入问题描述

elseif a == 3 then--【公共服务】
--do()
eventsx = rnd(5)
mSleep(1330)--延时，给时间足够的跨度，以生成更随机的而数字
inputText(cun[cunx]..ggfw[eventsx])--输入事件标题
mSleep(100)
touchDown(1,387,480)--选择事件类别（尽量靠下，因为标题长了会往下移动）
touchUp(1,387,480)
mSleep(500)
touchDown(1,420,875)--选择"公共服务"
touchUp(1,420,875)
mSleep(1000)

touchDown(1,463,1280)--选择"问题地址"
touchUp(1,463,1280)
mSleep(200)
inputText(cun[cunx])--输入地址
mSleep(200)
touchDown(1,418,1451)--选择"问题描述"
touchUp(1,418,1451)
mSleep(200)
inputText(sec1[rnd(24)]..cun[cunx]..ggfw[eventsx].."。")--输入问题描述

elseif a == 4 then--【社会管理】
--do()
eventsx = rnd(5)
mSleep(1330)--延时，给时间足够的跨度，以生成更随机的而数字
inputText(cun[cunx]..shgl[eventsx])--输入事件标题
mSleep(100)
touchDown(1,387,480)--选择事件类别（尽量靠下，因为标题长了会往下移动）
touchUp(1,387,480)
mSleep(500)
touchDown(1,420,1010)--选择"社会管理"
touchUp(1,420,1010)
mSleep(1000)

touchDown(1,463,1280)--选择"问题地址"
touchUp(1,463,1280)
mSleep(200)
inputText(cun[cunx])--输入地址
mSleep(200)
touchDown(1,418,1451)--选择"问题描述"
touchUp(1,418,1451)
mSleep(200)
inputText(sec1[rnd(24)]..cun[cunx]..shgl[eventsx].."。")--输入问题描述

elseif a == 5 then--【环境保护】
--do()
eventsx = rnd(5)
mSleep(1330)--延时，给时间足够的跨度，以生成更随机的而数字
inputText(cun[cunx]..hjbh[eventsx])--输入事件标题
mSleep(100)
touchDown(1,387,480)--选择事件类别（尽量靠下，因为标题长了会往下移动）
touchUp(1,387,480)
mSleep(500)
touchDown(1,420,1152)--选择"环境保护"
touchUp(1,420,1152)
mSleep(500)

touchDown(1,463,1280)--选择"问题地址"
touchUp(1,463,1280)
mSleep(200)
inputText(cun[cunx])--输入地址
mSleep(200)
touchDown(1,418,1451)--选择"问题描述"
touchUp(1,418,1451)
mSleep(200)
inputText(sec1[rnd(24)]..cun[cunx]..hjbh[eventsx].."。")--输入问题描述

elseif a == 6 then--【消防安全】
--do()
eventsx = rnd(5)
mSleep(1330)--延时，给时间足够的跨度，以生成更随机的而数字
inputText(cun[cunx]..xfaq[eventsx])--输入事件标题
mSleep(100)
touchDown(1,387,480)--选择事件类别（尽量靠下，因为标题长了会往下移动）
touchUp(1,387,480)
mSleep(500)
touchDown(1,420,1323)--选择"消防安全"
touchUp(1,420,1323)
mSleep(500)

touchDown(1,463,1280)--选择"问题地址"
touchUp(1,463,1280)
mSleep(200)
inputText(cun[cunx])--输入地址
mSleep(200)
touchDown(1,418,1451)--选择"问题描述"
touchUp(1,418,1451)
mSleep(200)
inputText(sec1[rnd(24)]..cun[cunx]..xfaq[eventsx].."。")--输入问题描述

else
--do()
end

touchDown(128,1446); --在 () 按下
mSleep(30);
touchMove(128, 1288); --移动到 ()
mSleep(30);
touchUp(128, 1288); --在 () 抬起
mSleep(1000);

touchDown(1,299,1789)--按下“提交”
mSleep(20)
touchUp(1,260,1654)
mSleep(1000)

os.execute("am force-stop com.jp.activity")
--closeApp("com.jp.activity"); 


end
switchTSInputMethod(false);--切换到原输入法