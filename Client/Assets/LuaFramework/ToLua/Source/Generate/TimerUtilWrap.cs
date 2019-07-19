﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class TimerUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TimerUtil), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("AddTimer", AddTimer);
		L.RegFunction("RemoveTimer", RemoveTimer);
		L.RegFunction("PauseTimer", PauseTimer);
		L.RegFunction("ResumeTimer", ResumeTimer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("timerEvenFunc", get_timerEvenFunc, set_timerEvenFunc);
		L.RegVar("Instance", get_Instance, set_Instance);
		L.RegFunction("CSFunc", TimerUtil_CSFunc);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddTimer(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 3 && TypeChecker.CheckTypes<TimerUtil.CSFunc>(L, 3))
			{
				TimerUtil obj = (TimerUtil)ToLua.CheckObject<TimerUtil>(L, 1);
				float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
				TimerUtil.CSFunc arg1 = (TimerUtil.CSFunc)ToLua.ToObject(L, 3);
				int o = obj.AddTimer(arg0, arg1);
				LuaDLL.lua_pushinteger(L, o);
				return 1;
			}
			else if (count == 3 && TypeChecker.CheckTypes<LuaInterface.LuaFunction>(L, 3))
			{
				TimerUtil obj = (TimerUtil)ToLua.CheckObject<TimerUtil>(L, 1);
				float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
				LuaFunction arg1 = ToLua.ToLuaFunction(L, 3);
				int o = obj.AddTimer(arg0, arg1);
				LuaDLL.lua_pushinteger(L, o);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: TimerUtil.AddTimer");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int RemoveTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimerUtil obj = (TimerUtil)ToLua.CheckObject<TimerUtil>(L, 1);
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveTimer(arg0);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int PauseTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimerUtil obj = (TimerUtil)ToLua.CheckObject<TimerUtil>(L, 1);
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.PauseTimer(arg0);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ResumeTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimerUtil obj = (TimerUtil)ToLua.CheckObject<TimerUtil>(L, 1);
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ResumeTimer(arg0);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_timerEvenFunc(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			TimerUtil obj = (TimerUtil)o;
			TimerUtil.CSFunc ret = obj.timerEvenFunc;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index timerEvenFunc on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, TimerUtil.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_timerEvenFunc(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			TimerUtil obj = (TimerUtil)o;
			TimerUtil.CSFunc arg0 = (TimerUtil.CSFunc)ToLua.CheckDelegate<TimerUtil.CSFunc>(L, 2);
			obj.timerEvenFunc = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index timerEvenFunc on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_Instance(IntPtr L)
	{
		try
		{
			TimerUtil arg0 = (TimerUtil)ToLua.CheckObject<TimerUtil>(L, 2);
			TimerUtil.Instance = arg0;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int TimerUtil_CSFunc(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);

			if (count == 1)
			{
				Delegate arg1 = DelegateTraits<TimerUtil.CSFunc>.Create(func);
				ToLua.Push(L, arg1);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate arg1 = DelegateTraits<TimerUtil.CSFunc>.Create(func, self);
				ToLua.Push(L, arg1);
			}
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
