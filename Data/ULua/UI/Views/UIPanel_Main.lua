---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by wanggang.
--- DateTime: 2019/7/14 8:35
---

UIPanel_Main = UIBaseView.New(UIConst.UIPanel_Main);

local _M = UIPanel_Main;

function _M:OnCreate()
    print("UIPanel_Main OnCreate");
end

function _M:OnRegisterMessage()
    print("UIPanel_Main OnRegisterMessage");
end

function _M:OnShow()
    print("UIPanel_Main OnShow");
end

function _M:OnClose()
    print("UIPanel_Main OnClose");
end

function _M:OnDestory()
    print("UIPanel_Main OnDestory");
end

function _M:ClickItem(sender)
    local index = tonumber(sender.transform.name);
    if index == 1 then
        -- 加载测试
        UIManager:Init(nil,nil,UIConst.UIPanel_Test)
    elseif index == 2 then
        -- 打开测试
        UIManager:Open(nil,UIConst.UIPanel_Test);
    elseif index == 3 then
        -- 加载打开测试
        UIManager:Open(nil,UIConst.UIPanel_Test);
    elseif index == 4 then
        -- 关闭测试
        UIManager:Close(UIConst.UIPanel_Test);
    elseif index == 5 then
        -- 卸载测试
        UIManager:Close(UIConst.UIPanel_Test,true);
    elseif index == 6 then
        -- 关闭卸载测试
        UIManager:Close(UIConst.UIPanel_Test,true);
    end
end