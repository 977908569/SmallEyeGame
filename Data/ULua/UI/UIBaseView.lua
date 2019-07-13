--[[
	UI分类
		1 主UI(自动流程)：每个UI集合必须有一个，打开UI集合前需要关闭当前UI集合，这时只需要处理打开逻辑就行；关闭当前UI集合后需要打开上次关闭的UI集合，这时只需要处理关闭逻辑就行。
		2 主UI(手动流程)：每个UI集合必须有一个，不受自动打开和关闭的影响。比如一些弹出框。
		3 子UI：和主UI一起构成UI集合
--]]
UIBaseView = Class("UIBaseView");

local _M = UIBaseView;

function _M:ctor(name)
	self.name = name;

	topLayerIndex = 0;			-- 上层UI设置：设置之后会一直显示在UI的最上层
	params = nil;				-- 页面打开后的参数
	-- 加载流程
	uiInitRequestId = 0;		-- 异步请求ID
	uiInitFinishCall = nil;		-- 请求加载完成后的回调
	uiInstanceId = 0;			-- UI的实例ID
	uiBindCore = nil;			-- 绑定Prefab中节点控件

	registerMessages = nil;		-- 注册的消息

	-- 打开关闭流程
	isShow = false;				-- 当前UI是否显示
end

-- 设置UI参数
function _M:SetParams(params)
	self.params = params;
end

-- 加载
function _M:Init(initFinishCall)
	-- 已经加载
	if self.uiInstanceId > 0 then 
		if initFinishCall then 
			initFinishCall();
		end
		return;
	end

	-- 开始加载
	self.uiInitFinishCall = initFinishCall;
	self:ShowFullScreenMask();
	self.uiInitRequestId = CreateUIPanelAsync(self:GetPrefabPath(),self.OnCreateInstance);
end

function _M:OnCreateInstance(intanceId)
	if intanceId == 0 then 
		print("OnCreateInstance is error " ,self.name);
		return;
	end
	
	self.uiInitRequestId = 0;
	self.uiInstanceId = intanceId;
	
	-- 绑定UICore
	self:BindUICore();
	
	-- 注册UI消息事件
	self:BaseRegisterMessage();

	-- 加载完成
	self:OnCreate();
	if self.uiInitFinishCall then 
		self.uiInitFinishCall();
		self.uiInitFinishCall = nil;
	end
end

-- 打开
-- isBack：当关闭当前UI时会自动打开前一个关闭的UI，这时isBack为true
function _M:Show(isBack)
	-- 1 计算UI层级
	self:SetUILayer();
	-- 2 加载atlas
	self:LoadAtlas(function()
			self:OnShowBefore(isBack);
		end);
end

-- 关闭
function _M:Close(isDestory,closeFinishCall)
	-- 1 释放图集
	self:ReleaseAtlas();
	
	-- 2 关闭GameObject
	local obj = GetGameObjectById(self.uiInstanceId);
	if not obj then 
		print("Close is error " .. self.name);
		return;
	end
	obj.gameObject:SetActive(false);
	
	-- 3 删除UI层级
	self:DelUILayer();
	
	-- 4 关闭完成
	self:OnClose();
	
	-- 5 关闭回调
	if closeFinishCall then 
		closeFinishCall();
	end
end

-- 卸载
function _M:UnInit()
	-- 1 清理消息
	self:RemoveRegisterMessage();

	-- 2 解绑UICore
	self:UnBindUIcore();

	-- 3 卸载GameObject
	DestoryGameObject(self.uiInstanceId);
	self.uiInstanceId = 0;

	-- 4 数据清理
	self:ClearParams();

	-- 4 卸载完成
	self:OnDestory();
end

-- 清理数据
function _M:ClearParams()
	self.params = nil;
end

-- 打开前处理
function _M:OnShowBefore()
	-- 获取实例
	local obj = GetGameObjectById(self.uiInstanceId);
	if not obj then 
		pring("OnShowBefore is error " .. self.name);
		return;
	end
	
	-- 显示
	obj.gameObject:SetActive(true);

	-- 显示完成
	self:OnShow();
end

-- 加载完成
function _M:OnCreate()
	-- 子类重写
end
-- 注册事件
function _M:OnRegisterMessage()
	-- 子类重写
end
-- 打开完成
function _M:OnShow()
	-- 子类重写
end
-- 关闭完成
function _M:OnClose()
	-- 子类重写
end
-- 卸载完成
function _M:OnDestory()
	-- 子类重写
end

-- 绑定UI控制：目的是为了让脚本方便的获取需要的节点或者控件
function _M:BindUICore()
	local obj = GetGameObjectById(self.uiInstanceId);
	if not obj then 
		print("BindUICore is error " .. self.name);
		return;
	end
	self.uiBindCore = obj.transform:GetComponent("UICore");
	if self.uiBindCore then 
		self.uiBindCore:Init(self);
	end
end
-- 解绑UICore：绑定的UI控件是当前的，如果卸载后再加载，里面保存的将是上一个UI的控件，所以需要删除
function _M:UnBindUIcore()
	if not self.uiBindCore then 
		return;
	end
	self.uiBindCore:UnInit(self);
end

function _M:BaseRegisterMessage()
	self:OnRegisterMessage();
end
function _M:RegisterMessage(msgName,call)
	if not self.registerMessages then 
		self.registerMessages = {};
	end
	if not self.registerMessages[msgName] then 
		self.registerMessages[msgName] = {};
	end
	local call = function(msg)
					-- 我们规定只有显示的UI才能收到更新，
					-- 如果需要隐藏的UI也收到更新那么换成打开UI的时候再刷新一次UI就行了
					if self:IsShow() then 
						call(msg);
					end
				end
	table.InsertOnlyValue(self.registerMessages[msgName],call);
	-- 注册消息
	RegisterMessage(msgName,call);
end
function _M:RemoveRegisterMessage()
	if not self.registerMessages then 
		return;
	end
	for k,v in pairs(self.registerMessages) do
		-- 删除消息
		RemoveMessage(k,v);
	end
	self.registerMessages = nil;
end

-- 加载Atals
function _M:LoadAtlas(onLoadAtlas)
	-- TODO 目前不处理UI和图集分离
	if onLoadAtlas then 
		onLoadAtlas();
	end
end
function _M:ReleaseAtlas()
	-- TODO 目前不处理UI和图集分离
end
-- 设置UI层级
function _M:SetUILayer()
	local obj = GetGameObjectById(self.uiInstanceId);
	if not obj then 
		print("SetUILayer is error " , self.name);
		return;
	end
	local layer = UILayer:CalculateLayer(self);
	self:AddUILayerHelper(layer);
end
-- 删除UI层级
function _M:DelUILayer()
	local obj = GetGameObjectById(self.uiInstanceId);
	if not obj then 
		print("SetUILayer is error " , self.name);
		return;
	end
	local layer = UILayer:GetLayer(self);
	self:AddUILayerHelper(-layer);
end
function _M:AddUILayerHelper(layer)
	local obj = GetGameObjectById(self.uiInstanceId);
	if not obj then 
		print("AddUILayerHelper is error " .. self.name);
		return;
	end
	local addLayer = layer * 100;
	-- TODO 获取所有UI下面的所有panel
	local panels = CommonUtil:GetUIPanels(obj);
	for i,v in ipairs(panels) do
		v.depth = v.depth + addLayer;
	end
end

-- 主UI(自动流程) 文件头有解释
function _M:IsMainUI()
	if UISetting[self.name] 
		and UISetting[self.name].uiType 
		and UISetting[self.name].uiType == 1 then 
		return true;
	end
	return false;
end
-- 主UI(手动流程) 文件头有解释
function _M:IsIgnoreMainUI()
	if UISetting[self.name]
		and UISetting[self.name].uiType 
		and UISetting[self.name].uiType == 2 then 
		return true;
	end
	return false;
end
-- 子UI
function _M:IsSonUI()
	if UISetting[self.name] 
		and UISetting[self.name].uiType 
		and UISetting[self.name].uiType == 3 then 
		return true;
	end
	return false;
end

-- 是否加载
function _M:IsInit()
	return self.uiInstanceId > 0;
end
-- 是否显示
function _M:IsShow()
	return self.isShow;
end

-- region
function _M:GetScriptPath()
	return UIConst[self.name][1];
end
function _M:GetPrefabPath()
	return UIConst[self.name][2];
end
function _M:GetName()
	return self.name;
end
function _M:GetTopLayerIndex()
	return self.topLayerIndex;
end
-- endregion