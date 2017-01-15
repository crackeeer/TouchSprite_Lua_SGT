ClassAPN = ".Settings$ApnSettingsActivity,"
ClassLogin = ".ui.LoginActivity91,"
ClassMain= ".ui.MainActivity,"
ClassSheQing = ".ui.SheQingAddActivity,"
ClassRiZhi = ".ui.GridLogAddActivity,"			

init(0);
--bid,class = frontAppBid(); 
--dialog(bid.."←bid，lass→"..class);
while (true) do
	bid,class = frontAppBid();
	
	if class == ClassAPN then
	 toast("APN");
	elseif class == ClassLogin then
			toast("Login");
			elseif class == ClassMain then
				toast("Main");
				elseif class == ClassRiZhi then
					toast("Rizhi");
					elseif class == ClassSheQing then
						toast("SheQing");
						else
							toast("No"); 
							end

	mSleep(3000);
    end