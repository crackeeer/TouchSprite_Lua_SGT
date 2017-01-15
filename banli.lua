
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

function rnd(max)--随机数
  --（lua的第1次random数不靠谱，取第3次的靠谱）
  local ret=0
  math.randomseed(tostring(os.time()):reverse():sub(1, 6))
  for i=1,3 do
    n = math.random(max)
    ret=n
  end
  return ret
end


init(0);
mSleep(300);
--switchTSInputMethod(true);--切换到触动精灵输入法，用于自动输入

path  = getPath();
banliList = readFile(path.."/lua/banli.txt");

for i=1,430 do
    mSleep(300);
	touchDown(1, 508, 318)--点击最上面一条“待办业务”
	touchUp(1, 508, 318)
	mSleep(1500)
	touchDown(1, 907, 264)--点击“事件处理”
	touchUp(1, 907, 264)
	mSleep(500)
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