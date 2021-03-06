

ClassAPN = ".Settings$ApnSettingsActivity,"
ClassLogin = ".ui.LoginActivity91,"
ClassMain= ".ui.MainActivity,"
ClassSheQing = ".ui.SheQingAddActivity,"
ClassRiZhi = ".ui.GridLogAddActivity,"



function deskTop()--回到桌面
	pressHomeKey();
	mSleep(500)
end

function readFile(path)--读取文件
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

function openApp()--进入登录界面

	r = runApp("com.jp.activity")--启动APP
	mSleep(6000)
	touchDown(1, 70, 775)--选择“社管通”APN
	touchUp(1, 70, 775)
	mSleep(1000)
	os.execute("input keyevent 4") --返回键（因为要选择APN）
	mSleep(500)
end

function rnd(max)
  --lua的第1次random数不靠谱，取第3次的靠谱
  local ret=0
   math.randomseed(tostring(os.time()):reverse():sub(1, 6))
  for i=1,3 do
    n = math.random(max)
    ret=n
  end
  return ret
end


function Login(id,pw)
	touchDown(1, 841, 318)--光标定位至ID框
	touchUp(1, 841, 318)
	mSleep(300)
	
	for var = 1,9 do --清除原有ID
    --inputText("\b")
	mSleep(100)
	os.execute("input keyevent 67")
	end
	inputText(id)
	mSleep(300)
	
	touchDown(1, 841, 453)--光标定位至密码框
	touchUp(1, 841, 453)
	mSleep(300)
	for var = 1,13 do --清除原有密码
    --inputText("\b")
	mSleep(100)
	os.execute("input keyevent 67")
	end
    inputText(pw)
	mSleep(300)
	touchDown(1, 525, 734)--点击登录
	touchUp(1, 525, 734)
	mSleep(1500)
end
	
function WriteRZ()
	touchDown(1, 502, 1070)--(三级网格长需要多一次点击)
	touchUp(1, 502, 1070)
	mSleep(500)
	touchDown(1, 300, 1528)--点击“日志采集”
	mSleep(100)
	touchUp(1, 300, 1528)
	mSleep(2000)--!近期在点击“日志采集”的时候，因网速原因会缓冲几秒钟，因此需要多一些延时。-- body
end
	
	function WriteRZ2()
	touchDown(1, 502, 1070)--(三级网格长需要多一次点击)
	touchUp(1, 502, 1070)
	mSleep(1000)
	touchDown(1, 770, 1234)--点击“日志采集”
	mSleep(100)
	touchUp(1, 770, 1234)
	mSleep(2000)--!近期在点击“日志采集”的时候，因网速原因会缓冲几秒钟，因此需要多一些延时。
end
	


function file_exists(file_name)
    local f = io.open(file_name, "r")
    return f ~= nil and f:close()
end



init(0);
mSleep(500);
switchTSInputMethod(true);--切换到触动精灵输入法，用于自动输入

path  = getPath();--初始化账号密码库 & 语句库
idList = readFile(path.."/lua/id3banli.txt");
pwList = readFile(path.."/lua/pw3banli.txt");
banliList = readFile(path.."/lua/banli.txt");

-------------三级网格长------------------

number = 1
for i,v in ipairs(idList) do  
	
	toast("当前进度"..tostring(number).."/21");-- 
	number = number + 1;
	
	openApp();
	bid,class = frontAppBid();
	if class == ClassLogin then --如果进入登录界面之后
	   Login(idList[i],pwList[i]);
	else  mSleep(7000) 
		  toast("未进入");
		  os.execute("input keyevent 4") --返回键（因为要选择APN）
		  mSleep(2000)  
			Login(idList[i],pwList[i]);  
	end

	touchDown(1, 761, 444)--点击最上面一条“待办业务”
	touchUp(1, 761, 444)
	
	for i=1,40 do
    mSleep(1500);
	touchDown(1, 508, 318)--点击最上面一条“待办业务”
	touchUp(1, 508, 318)
	mSleep(1500)
	touchDown(1, 907, 264)--点击“事件处理”
	touchUp(1, 907, 264)
	mSleep(1500)
	touchDown(1, 652, 422)--点击“输入框”
	touchUp(1, 652, 422)
	mSleep(200)
	inputText(banliList[rnd(7)])
	mSleep(700)
	touchDown(1, 447, 908)--点击取消“发送短信”
	touchUp(1, 447, 908)
	mSleep(300)
	touchDown(1, 594, 1161)--点击“提交”
	touchUp(1, 594, 1161)
	mSleep(300)
end

	

	mSleep(1000)
	os.execute("am force-stop com.jp.activity")
	mSleep(500)
end


mSleep(500)
switchTSInputMethod(false);--切换到原输入法
