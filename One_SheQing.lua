
--***********函数区**********


function deskTop()--回到桌面
	pressHomeKey();
	mSleep(1000)
end

function openApp()--进入登录界面

	r = runApp("com.jp.activity","com.jp.activity.ui.LoginActivity91")--启动APP
	mSleep(3000)--等待3秒，待加载完主界面
	os.execute("input keyevent 4") --返回键（因为要选择APN）
	mSleep(1000)
end

function rnd(max)--取随机数
  
  --lua的第1次random数不靠谱，取第3次的靠谱
  local ret=0
  math.randomseed(os.time())
  for i=1,3 do
    n = math.random(max)
    ret=n
  end
  return ret
end

function Login(id,pw)--登录社管通
	
	touchDown(1, 841, 318)--光标定位至ID框
	touchUp(1, 841, 318)
	mSleep(500)
	
	for var = 1,9 do --清除原有ID
    --inputText("\b")
	mSleep(200)
	os.execute("input keyevent 67")
	end
	inputText(id)
	mSleep(200)
	
	touchDown(1, 841, 453)--光标定位至密码框
	touchUp(1, 841, 453)
	mSleep(500)
	for var = 1,13 do --清除原有密码
    --inputText("\b")
	mSleep(200)
	os.execute("input keyevent 67")
	end
    inputText(pw)
	mSleep(200)
	touchDown(1, 525, 734)--点击登录
	mSleep(200)
end

function work()--开始登录后的操作
touchDown(1,338,446)--信息采集
touchUp(1,338,446)
mSleep(200)

end

--**********数据区******************



--***********************程序入口点*******************************
init(0);
mSleep(1000);
deskTop();
mSleep(100);

path  = getPath();--读取账户密码文件
idList = readFile(path.."/lua/sqid.txt");
pwList = readFile(path.."/lua/sqpw.txt");


openApp();
 Login(idList[1],pwList[1]);
work();
inputText("八府赵村小学门口有摊贩无证经营")--输入标题

touchDown(1,434,395)--选择事件类别
touchUp(1,434,395)
mSleep(200)

touchDown(1,419,959)--选择"社会管理"
touchUp(1,419,959)
mSleep(200)

touchDown(1,387,1207)--选择"问题地址"
touchUp(1,387,1207)
mSleep(200)

inputText("八府赵村")--输入地址
mSleep(200)

touchDown(1,408,1379)--选择"问题描述"
touchUp(1,408,1379)
mSleep(200)

inputText("在下村走访时发现，".."八府赵村".."小学门口".."有无证摊贩占道售卖三无小食品".."影响学生上下学秩序。")--输入问题描述
mSleep(200)
