library php_Xors3D;

uses
  Windows,  SysUtils, zendTypes, ZENDAPI,
  phpTypes, PHPAPI, Dialogs,
  Xors3d in 'Xors3d.pas', xscript in 'xscript.pas';


function TSDouble(param:pzval_array; I:Integer):Single;
begin
	if param[I]^._type = 2 then
		Result := param[I]^.value.dval
	else
		Result := param[I]^.value.lval;
end;


function ZendVariant(param:pzval_array; I:Integer):Variant;
begin
  case param[I]^._type of
    1:
      Result := param[I]^.value.lval;
    2:
      Result := param[I]^.value.dval;
    3:
      Result := bool(param[I]^.value.lval);
    6:
      Result := AnsiChar(param[I]^.value.str.val);
  end;
end;

{					XScript					}

procedure xLoadScriptCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadScript(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xExecuteScriptCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xExecuteScript(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xDeleteScriptCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteScript(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetIntegerVariableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetIntegerVariable(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetIntegerVariableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;

	return_value^._type := 1;
	return_value^.value.lval := xGetIntegerVariable(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xSetFloatVariableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFloatVariable(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetFloatVariableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetFloatVariable(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xSetStringVariableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetStringVariable(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetStringVariableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xGetStringVariable(param[0]^.value.lval, param[1]^.value.str.val), true);
	dispose_pzval_array(param);
end;

procedure xRegisterFunctionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRegisterFunction(param[0]^.value.str.val, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetIntegerArgCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetIntegerArg(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFloatArgCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFloatArg(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetStringArgCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetStringArg(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetIntegerReturnCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetIntegerReturn();
end;

procedure xGetFloatReturnCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetFloatReturn();
end;

procedure xGetStringReturnCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xGetStringReturn(), true);
end;

procedure xCreateScriptCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateScript(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;


{					Xors3D					}

procedure xCreate3DLineCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 11 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreate3DLine(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), param[6]^.value.lval, param[7]^.value.lval, param[8]^.value.lval, param[9]^.value.lval, param[10]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineOriginCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	x3DLineOrigin(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure x3DLineAddNodeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	x3DLineAddNode(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure x3DLineColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	x3DLineColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure x3DLineUseZBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	x3DLineUseZBuffer(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure x3DLineOriginXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := x3DLineOriginX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineOriginYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := x3DLineOriginY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineOriginZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := x3DLineOriginZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineNodesCountCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := x3DLineNodesCount(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineNodeXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := x3DLineNodeX(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineNodeYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := x3DLineNodeY(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineNodeZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := x3DLineNodeZ(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := x3DLineRed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := x3DLineGreen(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := x3DLineBlue(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure x3DLineAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := x3DLineAlpha(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGet3DLineUseZBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGet3DLineUseZBuffer(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xDelete3DLineNodeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDelete3DLineNode(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClear3DLineCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClear3DLine(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadBrushCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadBrush(param[0]^.value.str.val, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3));
	dispose_pzval_array(param);
end;

procedure xCreateBrushCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateBrush(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2));
	dispose_pzval_array(param);
end;

procedure xFreeBrushCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeBrush(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetBrushTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetBrushTexture(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xBrushColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBrushAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushAlpha(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBrushShininessCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushShininess(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBrushBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushBlend(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBrushFXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushFX(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBrushTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushTexture(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetBrushNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xGetBrushName(param[0]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xBrushNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBrushName(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetBrushAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetBrushAlpha(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetBrushBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetBrushBlend(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetBrushRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetBrushRed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetBrushGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetBrushGreen(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetBrushBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetBrushBlue(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetBrushFXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetBrushFX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetBrushShininessCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetBrushShininess(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCameraFogModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraFogMode(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraFogColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraFogColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraFogRangeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraFogRange(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraClsColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraClsColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraProjModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraProjMode(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraClsModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraClsMode(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSphereInFrustumCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xSphereInFrustum(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	dispose_pzval_array(param);
end;

procedure xCameraClipPlaneCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraClipPlane(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraRangeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraRange(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraViewportCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraViewport(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraCropViewportCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraCropViewport(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateCameraCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateCamera(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCameraProjectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraProject(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraProject2DCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraProject2D(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xProjectedXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xProjectedX();
end;

procedure xProjectedYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xProjectedY();
end;

procedure xProjectedZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xProjectedZ();
end;

procedure xGetViewMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetViewMatrix(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetProjectionMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetProjectionMatrix(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCameraZoomCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraZoom(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetViewProjMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetViewProjMatrix(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCollisions(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearCollisionsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xClearCollisions();
	ZVAL_NULL(return_value);
end;

procedure xResetEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xResetEntity(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityRadiusCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityRadius(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityBoxCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityBox(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityType(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityCollidedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityCollided(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCountCollisionsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCountCollisions(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionNXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionNX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionNYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionNY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionNZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionNZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xCollisionTime(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCollisionEntity(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCollisionSurface(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCollisionTriangleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCollisionTriangle(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetEntityTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetEntityType(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xRenderPostEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRenderPostEffect(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreatePostEffectPolyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreatePostEffectPoly(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetFunctionAddressCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetFunctionAddress(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xLoadFXFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadFXFile(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xFreeEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeEffect(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEntityEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEntityEffect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetSurfaceEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetSurfaceEffect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetBonesArrayNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetBonesArrayName(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceBonesArrayNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceBonesArrayName(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectIntCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectInt(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectIntCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectInt(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectFloatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectFloat(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectFloatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectFloat(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectBoolCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectBool(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectBoolCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectBool(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectVectorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectVector(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), param[6]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectVectorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectVector(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), param[6]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectVectorArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectVectorArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectVectorArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectVectorArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectMatrixArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectMatrixArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectFloatArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectFloatArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectIntArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectIntArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectMatrixArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectMatrixArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectFloatArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectFloatArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectIntArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectIntArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateBufferVectorsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateBufferVectors(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xBufferVectorsSetElementCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBufferVectorsSetElement(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateBufferMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateBufferMatrix(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xBufferMatrixSetElementCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBufferMatrixSetElement(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBufferMatrixGetElementCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xBufferMatrixGetElement(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateBufferFloatsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateBufferFloats(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xBufferFloatsSetElementCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBufferFloatsSetElement(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xBufferFloatsGetElementCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xBufferFloatsGetElement(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xBufferDeleteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xBufferDelete(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectMatrixWithElementsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 19 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectMatrixWithElements(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6), TSDouble(param, 7), TSDouble(param, 8), TSDouble(param, 9), TSDouble(param, 10), TSDouble(param, 11), TSDouble(param, 12), TSDouble(param, 13), TSDouble(param, 14), TSDouble(param, 15), TSDouble(param, 16), TSDouble(param, 17), param[18]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectMatrix(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectMatrix(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectMatrixWithElementsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 19 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectMatrixWithElements(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6), TSDouble(param, 7), TSDouble(param, 8), TSDouble(param, 9), TSDouble(param, 10), TSDouble(param, 11), TSDouble(param, 12), TSDouble(param, 13), TSDouble(param, 14), TSDouble(param, 15), TSDouble(param, 16), TSDouble(param, 17), param[18]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectEntityTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectEntityTexture(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectTexture(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectTexture(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceEffectMatrixSemanticCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceEffectMatrixSemantic(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectMatrixSemanticCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectMatrixSemantic(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeleteSurfaceConstantCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteSurfaceConstant(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeleteEffectConstantCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteEffectConstant(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearSurfaceConstantsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClearSurfaceConstants(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearEffectConstantsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClearEffectConstants(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEffectTechniqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEffectTechnique(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceTechniqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceTechnique(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xValidateEffectTechniqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xValidateEffectTechnique(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xSetEntityShaderLayerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEntityShaderLayer(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetEntityShaderLayerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetEntityShaderLayer(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetSurfaceShaderLayerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetSurfaceShaderLayer(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetSurfaceShaderLayerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetSurfaceShaderLayer(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetFXIntCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXInt(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXFloatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXFloat(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXBoolCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXBool(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXVectorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXVector(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXVectorArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXVectorArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXMatrixArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXMatrixArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXFloatArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXFloatArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXIntArrayCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXIntArray(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXEntityMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXEntityMatrix(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXTexture(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXMatrixSemanticCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXMatrixSemantic(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeleteFXConstantCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteFXConstant(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearFXConstantsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClearFXConstants(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFXTechniqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFXTechnique(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateEmitterCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateEmitter(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterEnableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEmitterEnable(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEmitterEnabledCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterEnabled(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterGetPSystemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterGetPSystem(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterAddParticleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterAddParticle(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterFreeParticleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEmitterFreeParticle(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEmitterValidateParticleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterValidateParticle(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterCountParticlesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterCountParticles(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterGetParticleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterGetParticle(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitterAliveCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitterAlive(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xExtractAnimSeqCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xExtractAnimSeq(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLoadAnimSeqCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadAnimSeq(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xSetAnimSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAnimSpeed(param[0]^.value.lval, TSDouble(param, 1), param[2]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xAnimSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xAnimSpeed(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xAnimatingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xAnimating(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xAnimTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xAnimTime(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xAnimateCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAnimate(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), param[3]^.value.lval, TSDouble(param, 4), param[5]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xAnimSeqCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xAnimSeq(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xAnimLengthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xAnimLength(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xSetAnimTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAnimTime(param[0]^.value.lval, TSDouble(param, 1), param[2]^.value.lval, param[3]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetAnimFrameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAnimFrame(param[0]^.value.lval, TSDouble(param, 1), param[2]^.value.lval, param[3]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAutoFadeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAutoFade(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityOrderCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityOrder(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFreeEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeEntity(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCopyEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCopyEntity(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPaintEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPaintEntity(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityShininessCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityShininess(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityPickModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityPickMode(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityTexture(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityFXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityFX(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetParentCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetParent(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetFrustumSphereCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFrustumSphere(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCalculateFrustumVolumeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCalculateFrustumVolume(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityParentCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityParent(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xShowEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xShowEntity(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xHideEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xHideEntity(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xNameEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xNameEntity(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEntityQuaternionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEntityQuaternion(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEntityMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEntityMatrix(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAlpha(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntitySpecularColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntitySpecularColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAmbientColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAmbientColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityEmissiveColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityEmissiveColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityBlend(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetAlphaRefCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAlphaRef(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetAlphaFuncCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAlphaFunc(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateInstanceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateInstance(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFreezeInstancesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreezeInstances(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xInstancingAvaliableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xInstancingAvaliable();
end;

procedure xScaleEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xScaleEntity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPositionEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPositionEntity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMoveEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMoveEntity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTranslateEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTranslateEntity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRotateEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRotateEntity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTurnEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTurnEntity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPointEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPointEntity(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xAlignToVectorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAlignToVector(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval, TSDouble(param, 5));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityDistanceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityDistance(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetMatElementCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetMatElement(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityClassCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xEntityClass(param[0]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xGetEntityBrushCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetEntityBrush(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityVisibleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityVisible(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityScaleXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityScaleX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityScaleYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityScaleY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityScaleZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityScaleZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityRollCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityRoll(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityYawCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityYaw(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityPitch(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xEntityName(param[0]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xCountChildrenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCountChildren(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetChildCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetChild(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityInViewCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityInView(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFindChildCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xFindChild(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xGetEntityMatrixCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetEntityMatrix(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetEntityAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetEntityAlpha(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetAlphaRefCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetAlphaRef(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetAlphaFuncCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetAlphaFunc(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityRed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityGreen(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityBlue(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetEntityShininessCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetEntityShininess(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetEntityBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetEntityBlend(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetEntityFXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetEntityFX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityHiddenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityHidden(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMountPackFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMountPackFile(param[0]^.value.str.val, param[1]^.value.str.val, param[2]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xUnmountPackFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xUnmountPackFile(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xOpenFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xOpenFile(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xReadFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadFile(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xWriteFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xWriteFile(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xCloseFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCloseFile(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFilePosCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xFilePos(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSeekFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSeekFile(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFileTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xFileType(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xFileSizeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xFileSize(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xReadDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadDir(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xCloseDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCloseDir(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xNextFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xNextFile(param[0]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xCurrentDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xCurrentDir(), true);
end;

procedure xChangeDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xChangeDir(param[0]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateDir(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xDeleteDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xDeleteDir(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xCopyFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCopyFile(param[0]^.value.str.val, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xDeleteFileCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xDeleteFile(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xEofCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEof(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xReadByteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadByte(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xReadShortCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadShort(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xReadIntCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadInt(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xReadFloatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xReadFloat(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xReadStringCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xReadString(param[0]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xReadLineCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xReadLine(param[0]^.value.lval, param[1]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xWriteByteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWriteByte(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWriteShortCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWriteShort(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWriteIntCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWriteInt(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWriteFloatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWriteFloat(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWriteStringCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWriteString(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWriteLineCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWriteLine(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadFontCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadFont(param[0]^.value.str.val, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTextCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xText(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.str.val, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetFontCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetFont(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFreeFontCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeFont(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFontWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xFontWidth();
end;

procedure xFontHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xFontHeight();
end;

procedure xStringWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xStringWidth(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xStringHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xStringHeight(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xWinMessageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xWinMessage(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xGetMaxPixelShaderVersionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetMaxPixelShaderVersion();
end;

procedure xLineCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLine(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRectsOverlapCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xRectsOverlap(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xViewportCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xViewport(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xOvalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xOval(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xOriginCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xOrigin(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetMaxVertexShaderVersionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetMaxVertexShaderVersion();
end;

procedure xGetMaxAntiAliasCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetMaxAntiAlias();
end;

procedure xGetMaxTextureFilteringCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetMaxTextureFiltering();
end;

procedure xSetAntiAliasTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAntiAliasType(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xAppTitleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;

	xAppTitle(param[0]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetWNDCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetWND(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetRenderWindowCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetRenderWindow(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDestroyRenderWindowCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xDestroyRenderWindow();
	ZVAL_NULL(return_value);
end;

procedure xFlipCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xFlip();
	ZVAL_NULL(return_value);
end;

procedure xBackBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xBackBuffer();
end;

procedure xLockBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLockBuffer(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xUnlockBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xUnlockBuffer(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWritePixelFastCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWritePixelFast(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xReadPixelFastCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadPixelFast(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetPixelsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetPixels(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSaveBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSaveBuffer(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetCurrentBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetCurrentBuffer();
end;

procedure xBufferWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xBufferWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xBufferHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xBufferHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCatchTimestampCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCatchTimestamp();
end;

procedure xGetElapsedTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetElapsedTime(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetBuffer(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetMRTCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetMRT(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xUnSetMRTCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xUnSetMRT();
	ZVAL_NULL(return_value);
end;

procedure xGetNumberRTCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetNumberRT();
end;

procedure xTextureBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xTextureBuffer(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLoadBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLoadBuffer(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWritePixelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWritePixel(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCopyPixelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCopyPixel(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCopyPixelFastCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCopyPixelFast(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCopyRectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCopyRect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGraphicsBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGraphicsBuffer();
end;

procedure xGetColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetColor(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xReadPixelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xReadPixel(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGraphicsWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGraphicsWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGraphicsHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGraphicsHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGraphicsDepthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGraphicsDepth();
end;

procedure xColorRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xColorRed();
end;

procedure xColorGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xColorGreen();
end;

procedure xColorBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xColorBlue();
end;

procedure xClsColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClsColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClearWorld(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xCls();
	ZVAL_NULL(return_value);
end;

procedure xUpdateWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xUpdateWorld(TSDouble(param, 0));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRenderEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRenderEntity(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRenderWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRenderWorld(TSDouble(param, 0), param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetAutoTBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetAutoTB(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMaxClipPlanesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMaxClipPlanes();
end;

procedure xWireframeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWireframe(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDitherCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDither(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetSkinningMethodCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetSkinningMethod(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTrisRenderedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xTrisRendered();
end;

procedure xDIPCounterCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xDIPCounter();
end;

procedure xSurfRenderedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xSurfRendered();
end;

procedure xEntityRenderedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xEntityRendered();
end;

procedure xAmbientLightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAmbientLight(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetFPSCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetFPS();
end;

procedure xAntiAliasCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAntiAlias(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetTextureFilteringCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetTextureFiltering(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xStretchRectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 11 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xStretchRect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval, param[8]^.value.lval, param[9]^.value.lval, param[10]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xStretchBackBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xStretchBackBuffer(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetDeviceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetDevice();
end;

procedure xReleaseGraphicsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xReleaseGraphics();
	ZVAL_NULL(return_value);
end;

procedure xShowPointerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xShowPointer();
	ZVAL_NULL(return_value);
end;

procedure xHidePointerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xHidePointer();
	ZVAL_NULL(return_value);
end;

procedure xCreateDSSCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCreateDSS(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeleteDSSCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xDeleteDSS();
	ZVAL_NULL(return_value);
end;

procedure xGridColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xGridColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawGridCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawGrid(TSDouble(param, 0), TSDouble(param, 1), param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawBBoxCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawBBox(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGraphics3DCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xGraphics3D(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGraphicsAspectRatioCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xGraphicsAspectRatio(TSDouble(param, 0));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGraphicsBorderColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xGraphicsBorderColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetRenderWindowCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetRenderWindow();
end;

procedure xKeyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xKey(param[0]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetEngineSettingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetEngineSetting(param[0]^.value.str.val, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetEngineSettingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xGetEngineSetting(param[0]^.value.str.val), true);
	dispose_pzval_array(param);
end;

procedure xHWInstancingAvailableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xHWInstancingAvailable();
end;

procedure xShaderInstancingAvailableCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xShaderInstancingAvailable();
end;

procedure xSetShaderLayerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetShaderLayer(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetShaderLayerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetShaderLayer();
end;

procedure xDrawMovementGizmoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawMovementGizmo(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawScaleGizmoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawScaleGizmo(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawRotationGizmoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawRotationGizmo(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCheckMovementGizmoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCheckMovementGizmo(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCheckScaleGizmoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCheckScaleGizmo(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCheckRotationGizmoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCheckRotationGizmo(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCaptureWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xCaptureWorld();
	ZVAL_NULL(return_value);
end;

procedure xCountGfxModesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCountGfxModes();
end;

procedure xGfxModeWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGfxModeWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGfxModeHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGfxModeHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGfxModeDepthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGfxModeDepth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGfxModeExistsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGfxModeExists(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xAppWindowFrameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAppWindowFrame(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMillisecsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMillisecs();
end;

procedure xDeltaTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xDeltaTime(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xDeltaValueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xDeltaValue(TSDouble(param, 0), param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xAddDeviceLostCallbackCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAddDeviceLostCallback(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeleteDeviceLostCallbackCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteDeviceLostCallback(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xImageColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xImageColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xImageAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xImageAlpha(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xImageBufferCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageBuffer(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGrabImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xGrabImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFreeImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeImage(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadImage(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xLoadAnimImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadAnimImage(param[0]^.value.str.val, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSaveImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSaveImage(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawImageRectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawImageRect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xScaleImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xScaleImage(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xResizeImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xResizeImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRotateImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRotateImage(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xImageAngleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xImageAngle(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImagesCollideCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImagesCollide(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageRectCollideCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageRectCollide(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageRectOverlapCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageRectOverlap(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageXHandleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageXHandle(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageYHandleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageYHandle(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xHandleImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xHandleImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMidHandleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMidHandle(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xAutoMidHandleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAutoMidHandle(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTileImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTileImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xImagesOverlapCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImagesOverlap(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMaskImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMaskImage(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCopyImageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCopyImage(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xDrawBlockCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawBlock(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawBlockRectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawBlockRect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval, param[6]^.value.lval, param[7]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xImageActualWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageActualWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xImageActualHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xImageActualHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFlushKeysCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xFlushKeys();
	ZVAL_NULL(return_value);
end;

procedure xFlushMouseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xFlushMouse();
	ZVAL_NULL(return_value);
end;

procedure xKeyHitCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xKeyHit(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xKeyUpCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xKeyUp(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xWaitKeyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xWaitKey();
	ZVAL_NULL(return_value);
end;

procedure xMouseHitCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMouseHit(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xKeyDownCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xKeyDown(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetKeyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetKey();
end;

procedure xMouseDownCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMouseDown(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMouseUpCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMouseUp(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetMouseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetMouse();
end;

procedure xMouseXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseX();
end;

procedure xMouseYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseY();
end;

procedure xMouseZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseZ();
end;

procedure xMouseXSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseXSpeed();
end;

procedure xMouseYSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseYSpeed();
end;

procedure xMouseZSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseZSpeed();
end;

procedure xMouseSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xMouseSpeed();
end;

procedure xMoveMouseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMoveMouse(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJoyTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyType(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyDownCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyDown(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyHitCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyHit(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetJoyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetJoy(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFlushJoyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xFlushJoy();
	ZVAL_NULL(return_value);
end;

procedure xWaitJoyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xWaitJoy(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyUCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyU(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyVCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyV(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyPitch(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyYawCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyYaw(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyRollCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyRoll(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyHatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJoyHat(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyXDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyXDir(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyYDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyYDir(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyZDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyZDir(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyUDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyUDir(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoyVDirCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xJoyVDir(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateLightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateLight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLightShadowEpsilonsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLightShadowEpsilons(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLightEnableShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLightEnableShadows(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLightShadowsEnabledCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLightShadowsEnabled(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLightRangeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLightRange(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLightColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLightColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLightConeAnglesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLightConeAngles(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateLogCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateLog(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.str.val, param[3]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xCloseLogCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCloseLog();
end;

procedure xGetLogStringCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xGetLogString(), true);
end;

procedure xClearLogStringCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xClearLogString();
	ZVAL_NULL(return_value);
end;

procedure xSetLogLevelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetLogLevel(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetLogTargetCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetLogTarget(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetLogLevelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetLogLevel();
end;

procedure xGetLogTargetCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetLogTarget();
end;

procedure xLogInfoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLogInfo(param[0]^.value.str.val, param[1]^.value.str.val, param[2]^.value.str.val, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLogMessageCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLogMessage(param[0]^.value.str.val, param[1]^.value.str.val, param[2]^.value.str.val, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLogWarningCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLogWarning(param[0]^.value.str.val, param[1]^.value.str.val, param[2]^.value.str.val, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLogErrorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLogError(param[0]^.value.str.val, param[1]^.value.str.val, param[2]^.value.str.val, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLogFatalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLogFatal(param[0]^.value.str.val, param[1]^.value.str.val, param[2]^.value.str.val, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateMesh(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLoadMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadMesh(param[0]^.value.str.val, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLoadMeshWithChildCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadMeshWithChild(param[0]^.value.str.val, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLoadAnimMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadAnimMesh(param[0]^.value.str.val, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateCubeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateCube(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateSphereCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateSphere(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateCylinderCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateCylinder(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateTorusCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateTorus(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateConeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateCone(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCopyMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCopyMesh(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xAddMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xAddMesh(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFlipMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFlipMesh(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPaintMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPaintMesh(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xFitMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFitMesh(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6), param[7]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMeshWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xMeshWidth(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMeshHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xMeshHeight(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMeshDepthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xMeshDepth(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xScaleMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xScaleMesh(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRotateMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRotateMesh(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPositionMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPositionMesh(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xUpdateNormalsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xUpdateNormals(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xUpdateNCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xUpdateN(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xUpdateTBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xUpdateTB(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMeshesBBIntersectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMeshesBBIntersect(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMeshesIntersectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMeshesIntersect(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetMeshVBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetMeshVB(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetMeshIBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetMeshIB(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetMeshVBSizeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetMeshVBSize(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetMeshIBSizeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetMeshIBSize(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xDeleteMeshVBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteMeshVB(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeleteMeshIBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteMeshIB(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCountSurfacesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCountSurfaces(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetSurface(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreatePivotCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreatePivot(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFindSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xFindSurface(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreatePolyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreatePoly(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMeshSingleSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMeshSingleSurface(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSaveMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xSaveMesh(param[0]^.value.lval, param[1]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xLightMeshCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 8 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLightMesh(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6), TSDouble(param, 7));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMeshPrimitiveTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMeshPrimitiveType(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticlePositionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticlePosition(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleVeclocityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleVeclocity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleVXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleVX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleVYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleVY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleVZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleVZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleRotationCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleRotation(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticlePitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticlePitch(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleYawCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleYaw(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleRollCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleRoll(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleTorqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleTorque(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleTPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleTPitch(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleTYawCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleTYaw(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleTRollCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleTRoll(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleSetAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleSetAlpha(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleGetAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleGetAlpha(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleColor(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleRed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleGreen(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleBlue(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleScaleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleScale(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleSXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleSX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleSYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleSY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleScaleSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xParticleScaleSpeed(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xParticleScaleSpeedXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleScaleSpeedX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xParticleScaleSpeedYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xParticleScaleSpeedY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityAddDummyShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddDummyShape(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddBoxShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddBoxShape(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddSphereShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddSphereShape(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddCapsuleShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddCapsuleShape(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddConeShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddConeShape(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddCylinderShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddCylinderShape(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddTriMeshShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddTriMeshShape(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAddHullShapeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAddHullShape(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWorldGravityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWorldGravity(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xWorldGravityXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xWorldGravityX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xWorldGravityYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xWorldGravityY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xWorldGravityZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xWorldGravityZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xWorldFrequencyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xWorldFrequency(TSDouble(param, 0), param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityApplyCentralForceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityApplyCentralForce(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityApplyCentralImpulseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityApplyCentralImpulse(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityApplyTorqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityApplyTorque(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityApplyTorqueImpulseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityApplyTorqueImpulse(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityApplyForceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityApplyForce(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityApplyImpulseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityApplyImpulse(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityReleaseForcesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityReleaseForces(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityDampingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityDamping(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetEntityLinearDampingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetEntityLinearDamping(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetEntityAngularDampingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetEntityAngularDamping(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityFrictionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityFriction(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetEntityFrictionCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xGetEntityFriction(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityForceXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityForceX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityForceYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityForceY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityForceZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityForceZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityTorqueXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityTorqueX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityTorqueYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityTorqueY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityTorqueZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityTorqueZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFreeEntityShapesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeEntityShapes(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCountContactsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCountContacts(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactNXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactNX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactNYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactNY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactNZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactNZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityContactDistanceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityContactDistance(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xContactEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xContactEntity(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateJointCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateJoint(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFreeJointCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeJoint(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointPivotACALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointPivotA(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointPivotBCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointPivotB(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointPivotAXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointPivotAX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointPivotAYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointPivotAY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointPivotAZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointPivotAZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointPivotBXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointPivotBX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointPivotBYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointPivotBY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointPivotBZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointPivotBZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointLinearLimitsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointLinearLimits(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointAngularLimitsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointAngularLimits(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointLinearLowerXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointLinearLowerX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointLinearLowerYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointLinearLowerY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointLinearLowerZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointLinearLowerZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointLinearUpperXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointLinearUpperX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointLinearUpperYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointLinearUpperY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointLinearUpperZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointLinearUpperZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointAngularLowerXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointAngularLowerX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointAngularLowerYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointAngularLowerY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointAngularLowerZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointAngularLowerZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointAngularUpperXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointAngularUpperX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointAngularUpperYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointAngularUpperY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointAngularUpperZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointAngularUpperZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJoint6dofSpringParamCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJoint6dofSpringParam(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointHingeAxisCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointHingeAxis(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointHingeLimitCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointHingeLimit(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointHingeLowerLimitCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointHingeLowerLimit(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointHingeUpperLimitCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xJointHingeUpperLimit(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xJointEnableMotorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointEnableMotor(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xJointHingeMotorTargetCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xJointHingeMotorTarget(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityLinearFactorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityLinearFactor(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityLinearFactorXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityLinearFactorX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityLinearFactorYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityLinearFactorY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityLinearFactorZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityLinearFactorZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityAngularFactorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityAngularFactor(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityAngularFactorXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityAngularFactorX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityAngularFactorYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityAngularFactorY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityAngularFactorZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityAngularFactorZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityGravityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityGravity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityGravityXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityGravityX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityGravityYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityGravityY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityGravityZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xEntityGravityZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPhysicsDebugRenderCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPhysicsDebugRender(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadPostEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadPostEffect(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xFreePostEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreePostEffect(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetPostEffectCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetPostEffect(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRenderPostEffectsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xRenderPostEffects();
	ZVAL_NULL(return_value);
end;

procedure xSetPostEffectIntCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetPostEffectInt(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetPostEffectFloatCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetPostEffectFloat(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetPostEffectBoolCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetPostEffectBool(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetPostEffectVectorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetPostEffectVector(param[0]^.value.lval, param[1]^.value.str.val, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetPostEffectTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetPostEffectTexture(param[0]^.value.lval, param[1]^.value.str.val, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDeletePostEffectConstantCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeletePostEffectConstant(param[0]^.value.lval, param[1]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearPostEffectConstantsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClearPostEffectConstants(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreatePSystemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreatePSystem(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemType(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetBlend(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetBlend(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetMaxParticlesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetMaxParticles(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetMaxParticlesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetMaxParticles(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetEmitterLifetimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetEmitterLifetime(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetEmitterLifetimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetEmitterLifetime(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetParticleLifetimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetParticleLifetime(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetParticleLifetimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetParticleLifetime(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetCreationIntervalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetCreationInterval(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetCreationIntervalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetCreationInterval(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetCreationFrequencyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetCreationFrequency(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetCreationFrequencyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetCreationFrequency(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetTexture(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetTexture(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTextureFramesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetTextureFrames(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTextureAnimationSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetTextureAnimationSpeed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetOffsetCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetOffset(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetOffsetMinXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetOffsetMinX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetOffsetMinYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetOffsetMinY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetOffsetMinZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetOffsetMinZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetOffsetMaxXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetOffsetMaxX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetOffsetMaxYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetOffsetMaxY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetOffsetMaxZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetOffsetMaxZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetVelocityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetVelocity(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetVelocityMinXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetVelocityMinX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetVelocityMinYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetVelocityMinY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetVelocityMinZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetVelocityMinZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetVelocityMaxXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetVelocityMaxX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetVelocityMaxYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetVelocityMaxY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetVelocityMaxZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetVelocityMaxZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemEnableFixedQuadsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemEnableFixedQuads(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemFixedQuadsUsedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemFixedQuadsUsed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetTorqueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetTorque(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTorqueMinXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetTorqueMinX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTorqueMinYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetTorqueMinY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTorqueMinZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetTorqueMinZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTorqueMaxXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetTorqueMaxX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTorqueMaxYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetTorqueMaxY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetTorqueMaxZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetTorqueMaxZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetGravityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetGravity(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetGravityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetGravity(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetAlpha(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAlpha(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetFadeSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetFadeSpeed(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetFadeSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetFadeSpeed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetParticleSizeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetParticleSize(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetSizeMinXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetSizeMinX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetSizeMinYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetSizeMinY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetSizeMaxXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetSizeMaxX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetSizeMaxYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetSizeMaxY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetScaleSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetScaleSpeed(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetScaleSpeedMinXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetScaleSpeedMinX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetScaleSpeedMinYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetScaleSpeedMinY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetScaleSpeedMaxXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetScaleSpeedMaxX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetScaleSpeedMaxYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetScaleSpeedMaxY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetAnglesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetAngles(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAnglesMinXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAnglesMinX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAnglesMinYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAnglesMinY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAnglesMinZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAnglesMinZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAnglesMaxXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAnglesMaxX(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAnglesMaxYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAnglesMaxY(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetAnglesMaxZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetAnglesMaxZ(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetColorModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetColorMode(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetColorModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetColorMode(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemSetColorsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetColors(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetBeginColorRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetBeginColorRed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetBeginColorGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetBeginColorGreen(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetBeginColorBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetBeginColorBlue(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetEndColorRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetEndColorRed(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetEndColorGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetEndColorGreen(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPSystemGetEndColorBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xPSystemGetEndColorBlue(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFreePSystemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreePSystem(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemSetParticleParentingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPSystemSetParticleParenting(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPSystemGetParticleParentingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPSystemGetParticleParenting(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLinePickCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLinePick(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	dispose_pzval_array(param);
end;

procedure xEntityPickCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityPick(param[0]^.value.lval, TSDouble(param, 1));
	dispose_pzval_array(param);
end;

procedure xCameraPickCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCameraPick(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPickedNXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xPickedNX();
end;

procedure xPickedNYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xPickedNY();
end;

procedure xPickedNZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xPickedNZ();
end;

procedure xPickedXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xPickedX();
end;

procedure xPickedYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xPickedY();
end;

procedure xPickedZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xPickedZ();
end;

procedure xPickedEntityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xPickedEntity();
end;

procedure xPickedSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xPickedSurface();
end;

procedure xPickedTriangleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xPickedTriangle();
end;

procedure xPickedTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xPickedTime();
end;

procedure xSetShadowsBlurCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetShadowsBlur(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetShadowShaderCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetShadowShader(param[0]^.value.str.val);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xInitShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xInitShadows(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetShadowParamsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetShadowParams(param[0]^.value.lval, TSDouble(param, 1), param[2]^.value.lval, TSDouble(param, 3));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRenderShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRenderShadows(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xShadowPriorityCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xShadowPriority(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraDisableShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraDisableShadows(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCameraEnableShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCameraEnableShadows(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityCastShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityCastShadows(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityReceiveShadowsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xEntityReceiveShadows(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xEntityIsCasterCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityIsCaster(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEntityIsReceiverCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEntityIsReceiver(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xLoadSoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadSound(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xLoad3DSoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoad3DSound(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xFreeSoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeSound(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoopSoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xLoopSound(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSoundPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSoundPitch(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSoundVolumeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSoundVolume(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSoundPanCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSoundPan(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPlaySoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPlaySound(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xStopChannelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xStopChannel(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPauseChannelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPauseChannel(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xResumeChannelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xResumeChannel(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xPlayMusicCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xPlayMusic(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xChannelPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xChannelPitch(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xChannelVolumeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xChannelVolume(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xChannelPanCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xChannelPan(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xChannelPlayingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xChannelPlaying(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xEmitSoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xEmitSound(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateListenerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateListener(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	dispose_pzval_array(param);
end;

procedure xGetListenerCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetListener();
end;

procedure xInitalizeSoundCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xInitalizeSound();
end;

procedure xCreateSpriteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateSprite(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSpriteViewModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSpriteViewMode(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xHandleSpriteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xHandleSprite(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadSpriteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadSprite(param[0]^.value.str.val, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xRotateSpriteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRotateSprite(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xScaleSpriteCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xScaleSprite(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCreateSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateSurface(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetSurfaceBrushCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetSurfaceBrush(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xAddVertexCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 7 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xAddVertex(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), TSDouble(param, 5), TSDouble(param, 6));
	dispose_pzval_array(param);
end;

procedure xAddTriangleCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xAddTriangle(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetSurfaceFrustumSphereCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetSurfaceFrustumSphere(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVertexCoordsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xVertexCoords(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVertexNormalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xVertexNormal(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVertexTangentCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xVertexTangent(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVertexBinormalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xVertexBinormal(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVertexColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xVertexColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, TSDouble(param, 5));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVertexTexCoordsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xVertexTexCoords(param[0]^.value.lval, param[1]^.value.lval, TSDouble(param, 2), TSDouble(param, 3), TSDouble(param, 4), param[5]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCountVerticesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCountVertices(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexNXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexNX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexNYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexNY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexNZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexNZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexTXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexTX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexTYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexTY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexTZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexTZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexBXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexBX(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexBYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexBY(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexBZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexBZ(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexUCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexU(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexVCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexV(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexWCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexW(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexRedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexRed(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexGreenCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexGreen(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexBlueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexBlue(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xVertexAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVertexAlpha(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTriangleVertexCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xTriangleVertex(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCountTrianglesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCountTriangles(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xPaintSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPaintSurface(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xClearSurface(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetSurfaceTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetSurfaceTexture(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFreeSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeSurface(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfacePrimitiveTypeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfacePrimitiveType(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceTexture(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceColorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceColor(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceAlphaCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceAlpha(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceShininessCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceShininess(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceBlend(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceFXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceFX(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceAlphaRefCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceAlphaRef(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSurfaceAlphaFuncCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSurfaceAlphaFunc(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xCPUNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xCPUName(), true);
end;

procedure xCPUVendorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xCPUVendor(), true);
end;

procedure xCPUFamilyCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCPUFamily();
end;

procedure xCPUModelCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCPUModel();
end;

procedure xCPUSteppingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCPUStepping();
end;

procedure xCPUSpeedCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCPUSpeed();
end;

procedure xVideoInfoCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xVideoInfo(), true);
end;

procedure xVideoAspectRatioCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xVideoAspectRatio();
end;

procedure xVideoAspectRatioStrCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	ZVAL_STRING(return_value, xVideoAspectRatioStr(), true);
end;

procedure xGetTotalPhysMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetTotalPhysMem();
end;

procedure xGetAvailPhysMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetAvailPhysMem();
end;

procedure xGetTotalPageMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetTotalPageMem();
end;

procedure xGetAvailPageMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetAvailPageMem();
end;

procedure xGetTotalVidMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetTotalVidMem();
end;

procedure xGetAvailVidMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetAvailVidMem();
end;

procedure xGetTotalVidLocalMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetTotalVidLocalMem();
end;

procedure xGetAvailVidLocalMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetAvailVidLocalMem();
end;

procedure xGetTotalVidNonlocalMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetTotalVidNonlocalMem();
end;

procedure xGetAvailVidNonlocalMemCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xGetAvailVidNonlocalMem();
end;

procedure xLoadTerrainCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadTerrain(param[0]^.value.str.val, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateTerrainCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateTerrain(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTerrainShadingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainShading(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xTerrainHeight(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTerrainSizeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xTerrainSize(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTerrainXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xTerrainX(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	dispose_pzval_array(param);
end;

procedure xTerrainYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xTerrainY(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	dispose_pzval_array(param);
end;

procedure xTerrainZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xTerrainZ(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2), TSDouble(param, 3));
	dispose_pzval_array(param);
end;

procedure xModifyTerrainCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xModifyTerrain(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, TSDouble(param, 3), param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainDetailCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainDetail(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainSplattingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainSplatting(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadTerrainTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadTerrainTexture(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xFreeTerrainTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeTerrainTexture(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainTextureLightmapCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainTextureLightmap(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainTexture(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainViewZoneCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainViewZone(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTerrainLODsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTerrainLODs(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTextureWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xTextureWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTextureHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xTextureHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 4 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateTexture(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xFreeTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xFreeTexture(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetTextureFilterCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetTextureFilter(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTextureBlendCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTextureBlend(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTextureCoordsCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTextureCoords(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTextureFilterCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTextureFilter(param[0]^.value.str.val, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xClearTextureFiltersCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	xClearTextureFilters();
	ZVAL_NULL(return_value);
end;

procedure xLoadTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadTexture(param[0]^.value.str.val, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTextureNameCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	ZVAL_STRING(return_value, xTextureName(param[0]^.value.lval), true);
	dispose_pzval_array(param);
end;

procedure xPositionTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xPositionTexture(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xScaleTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xScaleTexture(param[0]^.value.lval, TSDouble(param, 1), TSDouble(param, 2));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xRotateTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xRotateTexture(param[0]^.value.lval, TSDouble(param, 1));
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xLoadAnimTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 6 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xLoadAnimTexture(param[0]^.value.str.val, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval, param[5]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateTextureFromDataCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xCreateTextureFromData(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetTextureDataCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetTextureData(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetTextureDataPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetTextureDataPitch(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetTextureSurfaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetTextureSurface(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xGetTextureFramesCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xGetTextureFrames(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xSetCubeFaceCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetCubeFace(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xSetCubeModeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetCubeMode(param[0]^.value.lval, param[1]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xVectorPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVectorPitch(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2));
	dispose_pzval_array(param);
end;

procedure xVectorYawCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xVectorYaw(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2));
	dispose_pzval_array(param);
end;

procedure xDeltaPitchCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xDeltaPitch(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xDeltaYawCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 2 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xDeltaYaw(param[0]^.value.lval, param[1]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xTFormedXCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xTFormedX();
end;

procedure xTFormedYCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xTFormedY();
end;

procedure xTFormedZCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 2;
	return_value^.value.dval := xTFormedZ();
end;

procedure xTFormPointCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTFormPoint(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTFormVectorCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTFormVector(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xTFormNormalCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xTFormNormal(TSDouble(param, 0), TSDouble(param, 1), TSDouble(param, 2), param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xOpenMovieCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xOpenMovie(param[0]^.value.str.val);
	dispose_pzval_array(param);
end;

procedure xCloseMovieCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xCloseMovie(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xDrawMovieCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 5 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDrawMovie(param[0]^.value.lval, param[1]^.value.lval, param[2]^.value.lval, param[3]^.value.lval, param[4]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMovieWidthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMovieWidth(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMovieHeightCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMovieHeight(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMoviePlayingCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMoviePlaying(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMovieSeekCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMovieSeek(param[0]^.value.lval, TSDouble(param, 1), param[2]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMovieLengthCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xMovieLength(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMovieCurrentTimeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 2;
	return_value^.value.dval := xMovieCurrentTime(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xMoviePauseCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMoviePause(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMovieResumeCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xMovieResume(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xMovieTextureCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	return_value^._type := 1;
	return_value^.value.lval := xMovieTexture(param[0]^.value.lval);
	dispose_pzval_array(param);
end;

procedure xCreateWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xCreateWorld();
end;

procedure xSetActiveWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xSetActiveWorld(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure xGetActiveWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetActiveWorld();
end;

procedure xGetDefaultWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
begin
	return_value^._type := 1;
	return_value^.value.lval := xGetDefaultWorld();
end;

procedure xDeleteWorldCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 1 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;
	xDeleteWorld(param[0]^.value.lval);
	ZVAL_NULL(return_value);
	dispose_pzval_array(param);
end;

procedure CurveValueCALLBACK(ht:integer; return_value:pzval; return_value_ptr:ppzval; this_ptr:pzval; return_value_used:integer; TSRMLS_DC:pointer); cdecl;
var
  param:pzval_array;
  newvalue, oldvalue, increments:Single;
begin
	if ( not (zend_get_parameters_ex(ht, Param) = 0 )) then
	begin
		if ht <> 3 then
			begin
			zend_wrong_param_count(TSRMLS_DC);
			Exit;
		end;
	end;

	newvalue := TSDouble(param, 0);
	oldvalue := TSDouble(param, 1);
	increments := TSDouble(param, 2);

	if increments > 1 then oldvalue := oldvalue - (oldvalue - newvalue) / increments;
	if increments <= 1 then oldvalue := newvalue;

	return_value^._type := 2;
	return_value^.value.dval := oldvalue;


	dispose_pzval_array(param);
end;


var
  moduleEntry : Tzend_module_entry;
  module_entry_table : array[0..912]  of zend_function_entry;

function get_module : Pzend_module_entry; cdecl;
begin
  if not PHPLoaded then LoadPHP;

	ModuleEntry.size := sizeof(Tzend_module_entry);
	ModuleEntry.zend_api := ZEND_MODULE_API_NO;
	ModuleEntry.zts := USING_ZTS;
	ModuleEntry.Name := 'Xors3D';
	ModuleEntry.version := '1.0';

	Module_entry_table[0].fname := 'xCreate3DLine';
	Module_entry_table[0].handler := @xCreate3DLineCALLBACK;
	Module_entry_table[1].fname := 'x3DLineOrigin';
	Module_entry_table[1].handler := @x3DLineOriginCALLBACK;
	Module_entry_table[2].fname := 'x3DLineAddNode';
	Module_entry_table[2].handler := @x3DLineAddNodeCALLBACK;
	Module_entry_table[3].fname := 'x3DLineColor';
	Module_entry_table[3].handler := @x3DLineColorCALLBACK;
	Module_entry_table[4].fname := 'x3DLineUseZBuffer';
	Module_entry_table[4].handler := @x3DLineUseZBufferCALLBACK;
	Module_entry_table[5].fname := 'x3DLineOriginX';
	Module_entry_table[5].handler := @x3DLineOriginXCALLBACK;
	Module_entry_table[6].fname := 'x3DLineOriginY';
	Module_entry_table[6].handler := @x3DLineOriginYCALLBACK;
	Module_entry_table[7].fname := 'x3DLineOriginZ';
	Module_entry_table[7].handler := @x3DLineOriginZCALLBACK;
	Module_entry_table[8].fname := 'x3DLineNodesCount';
	Module_entry_table[8].handler := @x3DLineNodesCountCALLBACK;
	Module_entry_table[9].fname := 'x3DLineNodeX';
	Module_entry_table[9].handler := @x3DLineNodeXCALLBACK;
	Module_entry_table[10].fname := 'x3DLineNodeY';
	Module_entry_table[10].handler := @x3DLineNodeYCALLBACK;
	Module_entry_table[11].fname := 'x3DLineNodeZ';
	Module_entry_table[11].handler := @x3DLineNodeZCALLBACK;
	Module_entry_table[12].fname := 'x3DLineRed';
	Module_entry_table[12].handler := @x3DLineRedCALLBACK;
	Module_entry_table[13].fname := 'x3DLineGreen';
	Module_entry_table[13].handler := @x3DLineGreenCALLBACK;
	Module_entry_table[14].fname := 'x3DLineBlue';
	Module_entry_table[14].handler := @x3DLineBlueCALLBACK;
	Module_entry_table[15].fname := 'x3DLineAlpha';
	Module_entry_table[15].handler := @x3DLineAlphaCALLBACK;
	Module_entry_table[16].fname := 'xGet3DLineUseZBuffer';
	Module_entry_table[16].handler := @xGet3DLineUseZBufferCALLBACK;
	Module_entry_table[17].fname := 'xDelete3DLineNode';
	Module_entry_table[17].handler := @xDelete3DLineNodeCALLBACK;
	Module_entry_table[18].fname := 'xClear3DLine';
	Module_entry_table[18].handler := @xClear3DLineCALLBACK;
	Module_entry_table[19].fname := 'xLoadBrush';
	Module_entry_table[19].handler := @xLoadBrushCALLBACK;
	Module_entry_table[20].fname := 'xCreateBrush';
	Module_entry_table[20].handler := @xCreateBrushCALLBACK;
	Module_entry_table[21].fname := 'xFreeBrush';
	Module_entry_table[21].handler := @xFreeBrushCALLBACK;
	Module_entry_table[22].fname := 'xGetBrushTexture';
	Module_entry_table[22].handler := @xGetBrushTextureCALLBACK;
	Module_entry_table[23].fname := 'xBrushColor';
	Module_entry_table[23].handler := @xBrushColorCALLBACK;
	Module_entry_table[24].fname := 'xBrushAlpha';
	Module_entry_table[24].handler := @xBrushAlphaCALLBACK;
	Module_entry_table[25].fname := 'xBrushShininess';
	Module_entry_table[25].handler := @xBrushShininessCALLBACK;
	Module_entry_table[26].fname := 'xBrushBlend';
	Module_entry_table[26].handler := @xBrushBlendCALLBACK;
	Module_entry_table[27].fname := 'xBrushFX';
	Module_entry_table[27].handler := @xBrushFXCALLBACK;
	Module_entry_table[28].fname := 'xBrushTexture';
	Module_entry_table[28].handler := @xBrushTextureCALLBACK;
	Module_entry_table[29].fname := 'xGetBrushName';
	Module_entry_table[29].handler := @xGetBrushNameCALLBACK;
	Module_entry_table[30].fname := 'xBrushName';
	Module_entry_table[30].handler := @xBrushNameCALLBACK;
	Module_entry_table[31].fname := 'xGetBrushAlpha';
	Module_entry_table[31].handler := @xGetBrushAlphaCALLBACK;
	Module_entry_table[32].fname := 'xGetBrushBlend';
	Module_entry_table[32].handler := @xGetBrushBlendCALLBACK;
	Module_entry_table[33].fname := 'xGetBrushRed';
	Module_entry_table[33].handler := @xGetBrushRedCALLBACK;
	Module_entry_table[34].fname := 'xGetBrushGreen';
	Module_entry_table[34].handler := @xGetBrushGreenCALLBACK;
	Module_entry_table[35].fname := 'xGetBrushBlue';
	Module_entry_table[35].handler := @xGetBrushBlueCALLBACK;
	Module_entry_table[36].fname := 'xGetBrushFX';
	Module_entry_table[36].handler := @xGetBrushFXCALLBACK;
	Module_entry_table[37].fname := 'xGetBrushShininess';
	Module_entry_table[37].handler := @xGetBrushShininessCALLBACK;
	Module_entry_table[38].fname := 'xCameraFogMode';
	Module_entry_table[38].handler := @xCameraFogModeCALLBACK;
	Module_entry_table[39].fname := 'xCameraFogColor';
	Module_entry_table[39].handler := @xCameraFogColorCALLBACK;
	Module_entry_table[40].fname := 'xCameraFogRange';
	Module_entry_table[40].handler := @xCameraFogRangeCALLBACK;
	Module_entry_table[41].fname := 'xCameraClsColor';
	Module_entry_table[41].handler := @xCameraClsColorCALLBACK;
	Module_entry_table[42].fname := 'xCameraProjMode';
	Module_entry_table[42].handler := @xCameraProjModeCALLBACK;
	Module_entry_table[43].fname := 'xCameraClsMode';
	Module_entry_table[43].handler := @xCameraClsModeCALLBACK;
	Module_entry_table[44].fname := 'xSphereInFrustum';
	Module_entry_table[44].handler := @xSphereInFrustumCALLBACK;
	Module_entry_table[45].fname := 'xCameraClipPlane';
	Module_entry_table[45].handler := @xCameraClipPlaneCALLBACK;
	Module_entry_table[46].fname := 'xCameraRange';
	Module_entry_table[46].handler := @xCameraRangeCALLBACK;
	Module_entry_table[47].fname := 'xCameraViewport';
	Module_entry_table[47].handler := @xCameraViewportCALLBACK;
	Module_entry_table[48].fname := 'xCameraCropViewport';
	Module_entry_table[48].handler := @xCameraCropViewportCALLBACK;
	Module_entry_table[49].fname := 'xCreateCamera';
	Module_entry_table[49].handler := @xCreateCameraCALLBACK;
	Module_entry_table[50].fname := 'xCameraProject';
	Module_entry_table[50].handler := @xCameraProjectCALLBACK;
	Module_entry_table[51].fname := 'xCameraProject2D';
	Module_entry_table[51].handler := @xCameraProject2DCALLBACK;
	Module_entry_table[52].fname := 'xProjectedX';
	Module_entry_table[52].handler := @xProjectedXCALLBACK;
	Module_entry_table[53].fname := 'xProjectedY';
	Module_entry_table[53].handler := @xProjectedYCALLBACK;
	Module_entry_table[54].fname := 'xProjectedZ';
	Module_entry_table[54].handler := @xProjectedZCALLBACK;
	Module_entry_table[55].fname := 'xGetViewMatrix';
	Module_entry_table[55].handler := @xGetViewMatrixCALLBACK;
	Module_entry_table[56].fname := 'xGetProjectionMatrix';
	Module_entry_table[56].handler := @xGetProjectionMatrixCALLBACK;
	Module_entry_table[57].fname := 'xCameraZoom';
	Module_entry_table[57].handler := @xCameraZoomCALLBACK;
	Module_entry_table[58].fname := 'xGetViewProjMatrix';
	Module_entry_table[58].handler := @xGetViewProjMatrixCALLBACK;
	Module_entry_table[59].fname := 'xCollisions';
	Module_entry_table[59].handler := @xCollisionsCALLBACK;
	Module_entry_table[60].fname := 'xClearCollisions';
	Module_entry_table[60].handler := @xClearCollisionsCALLBACK;
	Module_entry_table[61].fname := 'xResetEntity';
	Module_entry_table[61].handler := @xResetEntityCALLBACK;
	Module_entry_table[62].fname := 'xEntityRadius';
	Module_entry_table[62].handler := @xEntityRadiusCALLBACK;
	Module_entry_table[63].fname := 'xEntityBox';
	Module_entry_table[63].handler := @xEntityBoxCALLBACK;
	Module_entry_table[64].fname := 'xEntityType';
	Module_entry_table[64].handler := @xEntityTypeCALLBACK;
	Module_entry_table[65].fname := 'xEntityCollided';
	Module_entry_table[65].handler := @xEntityCollidedCALLBACK;
	Module_entry_table[66].fname := 'xCountCollisions';
	Module_entry_table[66].handler := @xCountCollisionsCALLBACK;
	Module_entry_table[67].fname := 'xCollisionX';
	Module_entry_table[67].handler := @xCollisionXCALLBACK;
	Module_entry_table[68].fname := 'xCollisionY';
	Module_entry_table[68].handler := @xCollisionYCALLBACK;
	Module_entry_table[69].fname := 'xCollisionZ';
	Module_entry_table[69].handler := @xCollisionZCALLBACK;
	Module_entry_table[70].fname := 'xCollisionNX';
	Module_entry_table[70].handler := @xCollisionNXCALLBACK;
	Module_entry_table[71].fname := 'xCollisionNY';
	Module_entry_table[71].handler := @xCollisionNYCALLBACK;
	Module_entry_table[72].fname := 'xCollisionNZ';
	Module_entry_table[72].handler := @xCollisionNZCALLBACK;
	Module_entry_table[73].fname := 'xCollisionTime';
	Module_entry_table[73].handler := @xCollisionTimeCALLBACK;
	Module_entry_table[74].fname := 'xCollisionEntity';
	Module_entry_table[74].handler := @xCollisionEntityCALLBACK;
	Module_entry_table[75].fname := 'xCollisionSurface';
	Module_entry_table[75].handler := @xCollisionSurfaceCALLBACK;
	Module_entry_table[76].fname := 'xCollisionTriangle';
	Module_entry_table[76].handler := @xCollisionTriangleCALLBACK;
	Module_entry_table[77].fname := 'xGetEntityType';
	Module_entry_table[77].handler := @xGetEntityTypeCALLBACK;
	Module_entry_table[78].fname := 'xRenderPostEffect';
	Module_entry_table[78].handler := @xRenderPostEffectCALLBACK;
	Module_entry_table[79].fname := 'xCreatePostEffectPoly';
	Module_entry_table[79].handler := @xCreatePostEffectPolyCALLBACK;
	Module_entry_table[80].fname := 'xGetFunctionAddress';
	Module_entry_table[80].handler := @xGetFunctionAddressCALLBACK;
	Module_entry_table[81].fname := 'xLoadFXFile';
	Module_entry_table[81].handler := @xLoadFXFileCALLBACK;
	Module_entry_table[82].fname := 'xFreeEffect';
	Module_entry_table[82].handler := @xFreeEffectCALLBACK;
	Module_entry_table[83].fname := 'xSetEntityEffect';
	Module_entry_table[83].handler := @xSetEntityEffectCALLBACK;
	Module_entry_table[84].fname := 'xSetSurfaceEffect';
	Module_entry_table[84].handler := @xSetSurfaceEffectCALLBACK;
	Module_entry_table[85].fname := 'xSetBonesArrayName';
	Module_entry_table[85].handler := @xSetBonesArrayNameCALLBACK;
	Module_entry_table[86].fname := 'xSurfaceBonesArrayName';
	Module_entry_table[86].handler := @xSurfaceBonesArrayNameCALLBACK;
	Module_entry_table[87].fname := 'xSetEffectInt';
	Module_entry_table[87].handler := @xSetEffectIntCALLBACK;
	Module_entry_table[88].fname := 'xSurfaceEffectInt';
	Module_entry_table[88].handler := @xSurfaceEffectIntCALLBACK;
	Module_entry_table[89].fname := 'xSetEffectFloat';
	Module_entry_table[89].handler := @xSetEffectFloatCALLBACK;
	Module_entry_table[90].fname := 'xSurfaceEffectFloat';
	Module_entry_table[90].handler := @xSurfaceEffectFloatCALLBACK;
	Module_entry_table[91].fname := 'xSetEffectBool';
	Module_entry_table[91].handler := @xSetEffectBoolCALLBACK;
	Module_entry_table[92].fname := 'xSurfaceEffectBool';
	Module_entry_table[92].handler := @xSurfaceEffectBoolCALLBACK;
	Module_entry_table[93].fname := 'xSetEffectVector';
	Module_entry_table[93].handler := @xSetEffectVectorCALLBACK;
	Module_entry_table[94].fname := 'xSurfaceEffectVector';
	Module_entry_table[94].handler := @xSurfaceEffectVectorCALLBACK;
	Module_entry_table[95].fname := 'xSetEffectVectorArray';
	Module_entry_table[95].handler := @xSetEffectVectorArrayCALLBACK;
	Module_entry_table[96].fname := 'xSurfaceEffectVectorArray';
	Module_entry_table[96].handler := @xSurfaceEffectVectorArrayCALLBACK;
	Module_entry_table[97].fname := 'xSurfaceEffectMatrixArray';
	Module_entry_table[97].handler := @xSurfaceEffectMatrixArrayCALLBACK;
	Module_entry_table[98].fname := 'xSurfaceEffectFloatArray';
	Module_entry_table[98].handler := @xSurfaceEffectFloatArrayCALLBACK;
	Module_entry_table[99].fname := 'xSurfaceEffectIntArray';
	Module_entry_table[99].handler := @xSurfaceEffectIntArrayCALLBACK;
	Module_entry_table[100].fname := 'xSetEffectMatrixArray';
	Module_entry_table[100].handler := @xSetEffectMatrixArrayCALLBACK;
	Module_entry_table[101].fname := 'xSetEffectFloatArray';
	Module_entry_table[101].handler := @xSetEffectFloatArrayCALLBACK;
	Module_entry_table[102].fname := 'xSetEffectIntArray';
	Module_entry_table[102].handler := @xSetEffectIntArrayCALLBACK;
	Module_entry_table[103].fname := 'xCreateBufferVectors';
	Module_entry_table[103].handler := @xCreateBufferVectorsCALLBACK;
	Module_entry_table[104].fname := 'xBufferVectorsSetElement';
	Module_entry_table[104].handler := @xBufferVectorsSetElementCALLBACK;
	Module_entry_table[105].fname := 'xCreateBufferMatrix';
	Module_entry_table[105].handler := @xCreateBufferMatrixCALLBACK;
	Module_entry_table[106].fname := 'xBufferMatrixSetElement';
	Module_entry_table[106].handler := @xBufferMatrixSetElementCALLBACK;
	Module_entry_table[107].fname := 'xBufferMatrixGetElement';
	Module_entry_table[107].handler := @xBufferMatrixGetElementCALLBACK;
	Module_entry_table[108].fname := 'xCreateBufferFloats';
	Module_entry_table[108].handler := @xCreateBufferFloatsCALLBACK;
	Module_entry_table[109].fname := 'xBufferFloatsSetElement';
	Module_entry_table[109].handler := @xBufferFloatsSetElementCALLBACK;
	Module_entry_table[110].fname := 'xBufferFloatsGetElement';
	Module_entry_table[110].handler := @xBufferFloatsGetElementCALLBACK;
	Module_entry_table[111].fname := 'xBufferDelete';
	Module_entry_table[111].handler := @xBufferDeleteCALLBACK;
	Module_entry_table[112].fname := 'xSetEffectMatrixWithElements';
	Module_entry_table[112].handler := @xSetEffectMatrixWithElementsCALLBACK;
	Module_entry_table[113].fname := 'xSetEffectMatrix';
	Module_entry_table[113].handler := @xSetEffectMatrixCALLBACK;
	Module_entry_table[114].fname := 'xSurfaceEffectMatrix';
	Module_entry_table[114].handler := @xSurfaceEffectMatrixCALLBACK;
	Module_entry_table[115].fname := 'xSurfaceEffectMatrixWithElements';
	Module_entry_table[115].handler := @xSurfaceEffectMatrixWithElementsCALLBACK;
	Module_entry_table[116].fname := 'xSetEffectEntityTexture';
	Module_entry_table[116].handler := @xSetEffectEntityTextureCALLBACK;
	Module_entry_table[117].fname := 'xSetEffectTexture';
	Module_entry_table[117].handler := @xSetEffectTextureCALLBACK;
	Module_entry_table[118].fname := 'xSurfaceEffectTexture';
	Module_entry_table[118].handler := @xSurfaceEffectTextureCALLBACK;
	Module_entry_table[119].fname := 'xSurfaceEffectMatrixSemantic';
	Module_entry_table[119].handler := @xSurfaceEffectMatrixSemanticCALLBACK;
	Module_entry_table[120].fname := 'xSetEffectMatrixSemantic';
	Module_entry_table[120].handler := @xSetEffectMatrixSemanticCALLBACK;
	Module_entry_table[121].fname := 'xDeleteSurfaceConstant';
	Module_entry_table[121].handler := @xDeleteSurfaceConstantCALLBACK;
	Module_entry_table[122].fname := 'xDeleteEffectConstant';
	Module_entry_table[122].handler := @xDeleteEffectConstantCALLBACK;
	Module_entry_table[123].fname := 'xClearSurfaceConstants';
	Module_entry_table[123].handler := @xClearSurfaceConstantsCALLBACK;
	Module_entry_table[124].fname := 'xClearEffectConstants';
	Module_entry_table[124].handler := @xClearEffectConstantsCALLBACK;
	Module_entry_table[125].fname := 'xSetEffectTechnique';
	Module_entry_table[125].handler := @xSetEffectTechniqueCALLBACK;
	Module_entry_table[126].fname := 'xSurfaceTechnique';
	Module_entry_table[126].handler := @xSurfaceTechniqueCALLBACK;
	Module_entry_table[127].fname := 'xValidateEffectTechnique';
	Module_entry_table[127].handler := @xValidateEffectTechniqueCALLBACK;
	Module_entry_table[128].fname := 'xSetEntityShaderLayer';
	Module_entry_table[128].handler := @xSetEntityShaderLayerCALLBACK;
	Module_entry_table[129].fname := 'xGetEntityShaderLayer';
	Module_entry_table[129].handler := @xGetEntityShaderLayerCALLBACK;
	Module_entry_table[130].fname := 'xSetSurfaceShaderLayer';
	Module_entry_table[130].handler := @xSetSurfaceShaderLayerCALLBACK;
	Module_entry_table[131].fname := 'xGetSurfaceShaderLayer';
	Module_entry_table[131].handler := @xGetSurfaceShaderLayerCALLBACK;
	Module_entry_table[132].fname := 'xSetFXInt';
	Module_entry_table[132].handler := @xSetFXIntCALLBACK;
	Module_entry_table[133].fname := 'xSetFXFloat';
	Module_entry_table[133].handler := @xSetFXFloatCALLBACK;
	Module_entry_table[134].fname := 'xSetFXBool';
	Module_entry_table[134].handler := @xSetFXBoolCALLBACK;
	Module_entry_table[135].fname := 'xSetFXVector';
	Module_entry_table[135].handler := @xSetFXVectorCALLBACK;
	Module_entry_table[136].fname := 'xSetFXVectorArray';
	Module_entry_table[136].handler := @xSetFXVectorArrayCALLBACK;
	Module_entry_table[137].fname := 'xSetFXMatrixArray';
	Module_entry_table[137].handler := @xSetFXMatrixArrayCALLBACK;
	Module_entry_table[138].fname := 'xSetFXFloatArray';
	Module_entry_table[138].handler := @xSetFXFloatArrayCALLBACK;
	Module_entry_table[139].fname := 'xSetFXIntArray';
	Module_entry_table[139].handler := @xSetFXIntArrayCALLBACK;
	Module_entry_table[140].fname := 'xSetFXEntityMatrix';
	Module_entry_table[140].handler := @xSetFXEntityMatrixCALLBACK;
	Module_entry_table[141].fname := 'xSetFXTexture';
	Module_entry_table[141].handler := @xSetFXTextureCALLBACK;
	Module_entry_table[142].fname := 'xSetFXMatrixSemantic';
	Module_entry_table[142].handler := @xSetFXMatrixSemanticCALLBACK;
	Module_entry_table[143].fname := 'xDeleteFXConstant';
	Module_entry_table[143].handler := @xDeleteFXConstantCALLBACK;
	Module_entry_table[144].fname := 'xClearFXConstants';
	Module_entry_table[144].handler := @xClearFXConstantsCALLBACK;
	Module_entry_table[145].fname := 'xSetFXTechnique';
	Module_entry_table[145].handler := @xSetFXTechniqueCALLBACK;
	Module_entry_table[146].fname := 'xCreateEmitter';
	Module_entry_table[146].handler := @xCreateEmitterCALLBACK;
	Module_entry_table[147].fname := 'xEmitterEnable';
	Module_entry_table[147].handler := @xEmitterEnableCALLBACK;
	Module_entry_table[148].fname := 'xEmitterEnabled';
	Module_entry_table[148].handler := @xEmitterEnabledCALLBACK;
	Module_entry_table[149].fname := 'xEmitterGetPSystem';
	Module_entry_table[149].handler := @xEmitterGetPSystemCALLBACK;
	Module_entry_table[150].fname := 'xEmitterAddParticle';
	Module_entry_table[150].handler := @xEmitterAddParticleCALLBACK;
	Module_entry_table[151].fname := 'xEmitterFreeParticle';
	Module_entry_table[151].handler := @xEmitterFreeParticleCALLBACK;
	Module_entry_table[152].fname := 'xEmitterValidateParticle';
	Module_entry_table[152].handler := @xEmitterValidateParticleCALLBACK;
	Module_entry_table[153].fname := 'xEmitterCountParticles';
	Module_entry_table[153].handler := @xEmitterCountParticlesCALLBACK;
	Module_entry_table[154].fname := 'xEmitterGetParticle';
	Module_entry_table[154].handler := @xEmitterGetParticleCALLBACK;
	Module_entry_table[155].fname := 'xEmitterAlive';
	Module_entry_table[155].handler := @xEmitterAliveCALLBACK;
	Module_entry_table[156].fname := 'xExtractAnimSeq';
	Module_entry_table[156].handler := @xExtractAnimSeqCALLBACK;
	Module_entry_table[157].fname := 'xLoadAnimSeq';
	Module_entry_table[157].handler := @xLoadAnimSeqCALLBACK;
	Module_entry_table[158].fname := 'xSetAnimSpeed';
	Module_entry_table[158].handler := @xSetAnimSpeedCALLBACK;
	Module_entry_table[159].fname := 'xAnimSpeed';
	Module_entry_table[159].handler := @xAnimSpeedCALLBACK;
	Module_entry_table[160].fname := 'xAnimating';
	Module_entry_table[160].handler := @xAnimatingCALLBACK;
	Module_entry_table[161].fname := 'xAnimTime';
	Module_entry_table[161].handler := @xAnimTimeCALLBACK;
	Module_entry_table[162].fname := 'xAnimate';
	Module_entry_table[162].handler := @xAnimateCALLBACK;
	Module_entry_table[163].fname := 'xAnimSeq';
	Module_entry_table[163].handler := @xAnimSeqCALLBACK;
	Module_entry_table[164].fname := 'xAnimLength';
	Module_entry_table[164].handler := @xAnimLengthCALLBACK;
	Module_entry_table[165].fname := 'xSetAnimTime';
	Module_entry_table[165].handler := @xSetAnimTimeCALLBACK;
	Module_entry_table[166].fname := 'xSetAnimFrame';
	Module_entry_table[166].handler := @xSetAnimFrameCALLBACK;
	Module_entry_table[167].fname := 'xEntityAutoFade';
	Module_entry_table[167].handler := @xEntityAutoFadeCALLBACK;
	Module_entry_table[168].fname := 'xEntityOrder';
	Module_entry_table[168].handler := @xEntityOrderCALLBACK;
	Module_entry_table[169].fname := 'xFreeEntity';
	Module_entry_table[169].handler := @xFreeEntityCALLBACK;
	Module_entry_table[170].fname := 'xCopyEntity';
	Module_entry_table[170].handler := @xCopyEntityCALLBACK;
	Module_entry_table[171].fname := 'xPaintEntity';
	Module_entry_table[171].handler := @xPaintEntityCALLBACK;
	Module_entry_table[172].fname := 'xEntityShininess';
	Module_entry_table[172].handler := @xEntityShininessCALLBACK;
	Module_entry_table[173].fname := 'xEntityPickMode';
	Module_entry_table[173].handler := @xEntityPickModeCALLBACK;
	Module_entry_table[174].fname := 'xEntityTexture';
	Module_entry_table[174].handler := @xEntityTextureCALLBACK;
	Module_entry_table[175].fname := 'xEntityFX';
	Module_entry_table[175].handler := @xEntityFXCALLBACK;
	Module_entry_table[176].fname := 'xGetParent';
	Module_entry_table[176].handler := @xGetParentCALLBACK;
	Module_entry_table[177].fname := 'xSetFrustumSphere';
	Module_entry_table[177].handler := @xSetFrustumSphereCALLBACK;
	Module_entry_table[178].fname := 'xCalculateFrustumVolume';
	Module_entry_table[178].handler := @xCalculateFrustumVolumeCALLBACK;
	Module_entry_table[179].fname := 'xEntityParent';
	Module_entry_table[179].handler := @xEntityParentCALLBACK;
	Module_entry_table[180].fname := 'xShowEntity';
	Module_entry_table[180].handler := @xShowEntityCALLBACK;
	Module_entry_table[181].fname := 'xHideEntity';
	Module_entry_table[181].handler := @xHideEntityCALLBACK;
	Module_entry_table[182].fname := 'xNameEntity';
	Module_entry_table[182].handler := @xNameEntityCALLBACK;
	Module_entry_table[183].fname := 'xSetEntityQuaternion';
	Module_entry_table[183].handler := @xSetEntityQuaternionCALLBACK;
	Module_entry_table[184].fname := 'xSetEntityMatrix';
	Module_entry_table[184].handler := @xSetEntityMatrixCALLBACK;
	Module_entry_table[185].fname := 'xEntityAlpha';
	Module_entry_table[185].handler := @xEntityAlphaCALLBACK;
	Module_entry_table[186].fname := 'xEntityColor';
	Module_entry_table[186].handler := @xEntityColorCALLBACK;
	Module_entry_table[187].fname := 'xEntitySpecularColor';
	Module_entry_table[187].handler := @xEntitySpecularColorCALLBACK;
	Module_entry_table[188].fname := 'xEntityAmbientColor';
	Module_entry_table[188].handler := @xEntityAmbientColorCALLBACK;
	Module_entry_table[189].fname := 'xEntityEmissiveColor';
	Module_entry_table[189].handler := @xEntityEmissiveColorCALLBACK;
	Module_entry_table[190].fname := 'xEntityBlend';
	Module_entry_table[190].handler := @xEntityBlendCALLBACK;
	Module_entry_table[191].fname := 'xSetAlphaRef';
	Module_entry_table[191].handler := @xSetAlphaRefCALLBACK;
	Module_entry_table[192].fname := 'xSetAlphaFunc';
	Module_entry_table[192].handler := @xSetAlphaFuncCALLBACK;
	Module_entry_table[193].fname := 'xCreateInstance';
	Module_entry_table[193].handler := @xCreateInstanceCALLBACK;
	Module_entry_table[194].fname := 'xFreezeInstances';
	Module_entry_table[194].handler := @xFreezeInstancesCALLBACK;
	Module_entry_table[195].fname := 'xInstancingAvaliable';
	Module_entry_table[195].handler := @xInstancingAvaliableCALLBACK;
	Module_entry_table[196].fname := 'xScaleEntity';
	Module_entry_table[196].handler := @xScaleEntityCALLBACK;
	Module_entry_table[197].fname := 'xPositionEntity';
	Module_entry_table[197].handler := @xPositionEntityCALLBACK;
	Module_entry_table[198].fname := 'xMoveEntity';
	Module_entry_table[198].handler := @xMoveEntityCALLBACK;
	Module_entry_table[199].fname := 'xTranslateEntity';
	Module_entry_table[199].handler := @xTranslateEntityCALLBACK;
	Module_entry_table[200].fname := 'xRotateEntity';
	Module_entry_table[200].handler := @xRotateEntityCALLBACK;
	Module_entry_table[201].fname := 'xTurnEntity';
	Module_entry_table[201].handler := @xTurnEntityCALLBACK;
	Module_entry_table[202].fname := 'xPointEntity';
	Module_entry_table[202].handler := @xPointEntityCALLBACK;
	Module_entry_table[203].fname := 'xAlignToVector';
	Module_entry_table[203].handler := @xAlignToVectorCALLBACK;
	Module_entry_table[204].fname := 'xEntityDistance';
	Module_entry_table[204].handler := @xEntityDistanceCALLBACK;
	Module_entry_table[205].fname := 'xGetMatElement';
	Module_entry_table[205].handler := @xGetMatElementCALLBACK;
	Module_entry_table[206].fname := 'xEntityClass';
	Module_entry_table[206].handler := @xEntityClassCALLBACK;
	Module_entry_table[207].fname := 'xGetEntityBrush';
	Module_entry_table[207].handler := @xGetEntityBrushCALLBACK;
	Module_entry_table[208].fname := 'xEntityX';
	Module_entry_table[208].handler := @xEntityXCALLBACK;
	Module_entry_table[209].fname := 'xEntityY';
	Module_entry_table[209].handler := @xEntityYCALLBACK;
	Module_entry_table[210].fname := 'xEntityZ';
	Module_entry_table[210].handler := @xEntityZCALLBACK;
	Module_entry_table[211].fname := 'xEntityVisible';
	Module_entry_table[211].handler := @xEntityVisibleCALLBACK;
	Module_entry_table[212].fname := 'xEntityScaleX';
	Module_entry_table[212].handler := @xEntityScaleXCALLBACK;
	Module_entry_table[213].fname := 'xEntityScaleY';
	Module_entry_table[213].handler := @xEntityScaleYCALLBACK;
	Module_entry_table[214].fname := 'xEntityScaleZ';
	Module_entry_table[214].handler := @xEntityScaleZCALLBACK;
	Module_entry_table[215].fname := 'xEntityRoll';
	Module_entry_table[215].handler := @xEntityRollCALLBACK;
	Module_entry_table[216].fname := 'xEntityYaw';
	Module_entry_table[216].handler := @xEntityYawCALLBACK;
	Module_entry_table[217].fname := 'xEntityPitch';
	Module_entry_table[217].handler := @xEntityPitchCALLBACK;
	Module_entry_table[218].fname := 'xEntityName';
	Module_entry_table[218].handler := @xEntityNameCALLBACK;
	Module_entry_table[219].fname := 'xCountChildren';
	Module_entry_table[219].handler := @xCountChildrenCALLBACK;
	Module_entry_table[220].fname := 'xGetChild';
	Module_entry_table[220].handler := @xGetChildCALLBACK;
	Module_entry_table[221].fname := 'xEntityInView';
	Module_entry_table[221].handler := @xEntityInViewCALLBACK;
	Module_entry_table[222].fname := 'xFindChild';
	Module_entry_table[222].handler := @xFindChildCALLBACK;
	Module_entry_table[223].fname := 'xGetEntityMatrix';
	Module_entry_table[223].handler := @xGetEntityMatrixCALLBACK;
	Module_entry_table[224].fname := 'xGetEntityAlpha';
	Module_entry_table[224].handler := @xGetEntityAlphaCALLBACK;
	Module_entry_table[225].fname := 'xGetAlphaRef';
	Module_entry_table[225].handler := @xGetAlphaRefCALLBACK;
	Module_entry_table[226].fname := 'xGetAlphaFunc';
	Module_entry_table[226].handler := @xGetAlphaFuncCALLBACK;
	Module_entry_table[227].fname := 'xEntityRed';
	Module_entry_table[227].handler := @xEntityRedCALLBACK;
	Module_entry_table[228].fname := 'xEntityGreen';
	Module_entry_table[228].handler := @xEntityGreenCALLBACK;
	Module_entry_table[229].fname := 'xEntityBlue';
	Module_entry_table[229].handler := @xEntityBlueCALLBACK;
	Module_entry_table[230].fname := 'xGetEntityShininess';
	Module_entry_table[230].handler := @xGetEntityShininessCALLBACK;
	Module_entry_table[231].fname := 'xGetEntityBlend';
	Module_entry_table[231].handler := @xGetEntityBlendCALLBACK;
	Module_entry_table[232].fname := 'xGetEntityFX';
	Module_entry_table[232].handler := @xGetEntityFXCALLBACK;
	Module_entry_table[233].fname := 'xEntityHidden';
	Module_entry_table[233].handler := @xEntityHiddenCALLBACK;
	Module_entry_table[234].fname := 'xMountPackFile';
	Module_entry_table[234].handler := @xMountPackFileCALLBACK;
	Module_entry_table[235].fname := 'xUnmountPackFile';
	Module_entry_table[235].handler := @xUnmountPackFileCALLBACK;
	Module_entry_table[236].fname := 'xOpenFile';
	Module_entry_table[236].handler := @xOpenFileCALLBACK;
	Module_entry_table[237].fname := 'xReadFile';
	Module_entry_table[237].handler := @xReadFileCALLBACK;
	Module_entry_table[238].fname := 'xWriteFile';
	Module_entry_table[238].handler := @xWriteFileCALLBACK;
	Module_entry_table[239].fname := 'xCloseFile';
	Module_entry_table[239].handler := @xCloseFileCALLBACK;
	Module_entry_table[240].fname := 'xFilePos';
	Module_entry_table[240].handler := @xFilePosCALLBACK;
	Module_entry_table[241].fname := 'xSeekFile';
	Module_entry_table[241].handler := @xSeekFileCALLBACK;
	Module_entry_table[242].fname := 'xFileType';
	Module_entry_table[242].handler := @xFileTypeCALLBACK;
	Module_entry_table[243].fname := 'xFileSize';
	Module_entry_table[243].handler := @xFileSizeCALLBACK;
	Module_entry_table[244].fname := 'xReadDir';
	Module_entry_table[244].handler := @xReadDirCALLBACK;
	Module_entry_table[245].fname := 'xCloseDir';
	Module_entry_table[245].handler := @xCloseDirCALLBACK;
	Module_entry_table[246].fname := 'xNextFile';
	Module_entry_table[246].handler := @xNextFileCALLBACK;
	Module_entry_table[247].fname := 'xCurrentDir';
	Module_entry_table[247].handler := @xCurrentDirCALLBACK;
	Module_entry_table[248].fname := 'xChangeDir';
	Module_entry_table[248].handler := @xChangeDirCALLBACK;
	Module_entry_table[249].fname := 'xCreateDir';
	Module_entry_table[249].handler := @xCreateDirCALLBACK;
	Module_entry_table[250].fname := 'xDeleteDir';
	Module_entry_table[250].handler := @xDeleteDirCALLBACK;
	Module_entry_table[251].fname := 'xCopyFile';
	Module_entry_table[251].handler := @xCopyFileCALLBACK;
	Module_entry_table[252].fname := 'xDeleteFile';
	Module_entry_table[252].handler := @xDeleteFileCALLBACK;
	Module_entry_table[253].fname := 'xEof';
	Module_entry_table[253].handler := @xEofCALLBACK;
	Module_entry_table[254].fname := 'xReadByte';
	Module_entry_table[254].handler := @xReadByteCALLBACK;
	Module_entry_table[255].fname := 'xReadShort';
	Module_entry_table[255].handler := @xReadShortCALLBACK;
	Module_entry_table[256].fname := 'xReadInt';
	Module_entry_table[256].handler := @xReadIntCALLBACK;
	Module_entry_table[257].fname := 'xReadFloat';
	Module_entry_table[257].handler := @xReadFloatCALLBACK;
	Module_entry_table[258].fname := 'xReadString';
	Module_entry_table[258].handler := @xReadStringCALLBACK;
	Module_entry_table[259].fname := 'xReadLine';
	Module_entry_table[259].handler := @xReadLineCALLBACK;
	Module_entry_table[260].fname := 'xWriteByte';
	Module_entry_table[260].handler := @xWriteByteCALLBACK;
	Module_entry_table[261].fname := 'xWriteShort';
	Module_entry_table[261].handler := @xWriteShortCALLBACK;
	Module_entry_table[262].fname := 'xWriteInt';
	Module_entry_table[262].handler := @xWriteIntCALLBACK;
	Module_entry_table[263].fname := 'xWriteFloat';
	Module_entry_table[263].handler := @xWriteFloatCALLBACK;
	Module_entry_table[264].fname := 'xWriteString';
	Module_entry_table[264].handler := @xWriteStringCALLBACK;
	Module_entry_table[265].fname := 'xWriteLine';
	Module_entry_table[265].handler := @xWriteLineCALLBACK;
	Module_entry_table[266].fname := 'xLoadFont';
	Module_entry_table[266].handler := @xLoadFontCALLBACK;
	Module_entry_table[267].fname := 'xText';
	Module_entry_table[267].handler := @xTextCALLBACK;
	Module_entry_table[268].fname := 'xSetFont';
	Module_entry_table[268].handler := @xSetFontCALLBACK;
	Module_entry_table[269].fname := 'xFreeFont';
	Module_entry_table[269].handler := @xFreeFontCALLBACK;
	Module_entry_table[270].fname := 'xFontWidth';
	Module_entry_table[270].handler := @xFontWidthCALLBACK;
	Module_entry_table[271].fname := 'xFontHeight';
	Module_entry_table[271].handler := @xFontHeightCALLBACK;
	Module_entry_table[272].fname := 'xStringWidth';
	Module_entry_table[272].handler := @xStringWidthCALLBACK;
	Module_entry_table[273].fname := 'xStringHeight';
	Module_entry_table[273].handler := @xStringHeightCALLBACK;
	Module_entry_table[274].fname := 'xWinMessage';
	Module_entry_table[274].handler := @xWinMessageCALLBACK;
	Module_entry_table[275].fname := 'xGetMaxPixelShaderVersion';
	Module_entry_table[275].handler := @xGetMaxPixelShaderVersionCALLBACK;
	Module_entry_table[276].fname := 'xLine';
	Module_entry_table[276].handler := @xLineCALLBACK;
	Module_entry_table[277].fname := 'xRect';
	Module_entry_table[277].handler := @xRectCALLBACK;
	Module_entry_table[278].fname := 'xRectsOverlap';
	Module_entry_table[278].handler := @xRectsOverlapCALLBACK;
	Module_entry_table[279].fname := 'xViewport';
	Module_entry_table[279].handler := @xViewportCALLBACK;
	Module_entry_table[280].fname := 'xOval';
	Module_entry_table[280].handler := @xOvalCALLBACK;
	Module_entry_table[281].fname := 'xOrigin';
	Module_entry_table[281].handler := @xOriginCALLBACK;
	Module_entry_table[282].fname := 'xGetMaxVertexShaderVersion';
	Module_entry_table[282].handler := @xGetMaxVertexShaderVersionCALLBACK;
	Module_entry_table[283].fname := 'xGetMaxAntiAlias';
	Module_entry_table[283].handler := @xGetMaxAntiAliasCALLBACK;
	Module_entry_table[284].fname := 'xGetMaxTextureFiltering';
	Module_entry_table[284].handler := @xGetMaxTextureFilteringCALLBACK;
	Module_entry_table[285].fname := 'xSetAntiAliasType';
	Module_entry_table[285].handler := @xSetAntiAliasTypeCALLBACK;
	Module_entry_table[286].fname := 'xAppTitle';
	Module_entry_table[286].handler := @xAppTitleCALLBACK;
	Module_entry_table[287].fname := 'xSetWND';
	Module_entry_table[287].handler := @xSetWNDCALLBACK;
	Module_entry_table[288].fname := 'xSetRenderWindow';
	Module_entry_table[288].handler := @xSetRenderWindowCALLBACK;
	Module_entry_table[289].fname := 'xDestroyRenderWindow';
	Module_entry_table[289].handler := @xDestroyRenderWindowCALLBACK;
	Module_entry_table[290].fname := 'xFlip';
	Module_entry_table[290].handler := @xFlipCALLBACK;
	Module_entry_table[291].fname := 'xBackBuffer';
	Module_entry_table[291].handler := @xBackBufferCALLBACK;
	Module_entry_table[292].fname := 'xLockBuffer';
	Module_entry_table[292].handler := @xLockBufferCALLBACK;
	Module_entry_table[293].fname := 'xUnlockBuffer';
	Module_entry_table[293].handler := @xUnlockBufferCALLBACK;
	Module_entry_table[294].fname := 'xWritePixelFast';
	Module_entry_table[294].handler := @xWritePixelFastCALLBACK;
	Module_entry_table[295].fname := 'xReadPixelFast';
	Module_entry_table[295].handler := @xReadPixelFastCALLBACK;
	Module_entry_table[296].fname := 'xGetPixels';
	Module_entry_table[296].handler := @xGetPixelsCALLBACK;
	Module_entry_table[297].fname := 'xSaveBuffer';
	Module_entry_table[297].handler := @xSaveBufferCALLBACK;
	Module_entry_table[298].fname := 'xGetCurrentBuffer';
	Module_entry_table[298].handler := @xGetCurrentBufferCALLBACK;
	Module_entry_table[299].fname := 'xBufferWidth';
	Module_entry_table[299].handler := @xBufferWidthCALLBACK;
	Module_entry_table[300].fname := 'xBufferHeight';
	Module_entry_table[300].handler := @xBufferHeightCALLBACK;
	Module_entry_table[301].fname := 'xCatchTimestamp';
	Module_entry_table[301].handler := @xCatchTimestampCALLBACK;
	Module_entry_table[302].fname := 'xGetElapsedTime';
	Module_entry_table[302].handler := @xGetElapsedTimeCALLBACK;
	Module_entry_table[303].fname := 'xSetBuffer';
	Module_entry_table[303].handler := @xSetBufferCALLBACK;
	Module_entry_table[304].fname := 'xSetMRT';
	Module_entry_table[304].handler := @xSetMRTCALLBACK;
	Module_entry_table[305].fname := 'xUnSetMRT';
	Module_entry_table[305].handler := @xUnSetMRTCALLBACK;
	Module_entry_table[306].fname := 'xGetNumberRT';
	Module_entry_table[306].handler := @xGetNumberRTCALLBACK;
	Module_entry_table[307].fname := 'xTextureBuffer';
	Module_entry_table[307].handler := @xTextureBufferCALLBACK;
	Module_entry_table[308].fname := 'xLoadBuffer';
	Module_entry_table[308].handler := @xLoadBufferCALLBACK;
	Module_entry_table[309].fname := 'xWritePixel';
	Module_entry_table[309].handler := @xWritePixelCALLBACK;
	Module_entry_table[310].fname := 'xCopyPixel';
	Module_entry_table[310].handler := @xCopyPixelCALLBACK;
	Module_entry_table[311].fname := 'xCopyPixelFast';
	Module_entry_table[311].handler := @xCopyPixelFastCALLBACK;
	Module_entry_table[312].fname := 'xCopyRect';
	Module_entry_table[312].handler := @xCopyRectCALLBACK;
	Module_entry_table[313].fname := 'xGraphicsBuffer';
	Module_entry_table[313].handler := @xGraphicsBufferCALLBACK;
	Module_entry_table[314].fname := 'xGetColor';
	Module_entry_table[314].handler := @xGetColorCALLBACK;
	Module_entry_table[315].fname := 'xReadPixel';
	Module_entry_table[315].handler := @xReadPixelCALLBACK;
	Module_entry_table[316].fname := 'xGraphicsWidth';
	Module_entry_table[316].handler := @xGraphicsWidthCALLBACK;
	Module_entry_table[317].fname := 'xGraphicsHeight';
	Module_entry_table[317].handler := @xGraphicsHeightCALLBACK;
	Module_entry_table[318].fname := 'xGraphicsDepth';
	Module_entry_table[318].handler := @xGraphicsDepthCALLBACK;
	Module_entry_table[319].fname := 'xColorRed';
	Module_entry_table[319].handler := @xColorRedCALLBACK;
	Module_entry_table[320].fname := 'xColorGreen';
	Module_entry_table[320].handler := @xColorGreenCALLBACK;
	Module_entry_table[321].fname := 'xColorBlue';
	Module_entry_table[321].handler := @xColorBlueCALLBACK;
	Module_entry_table[322].fname := 'xClsColor';
	Module_entry_table[322].handler := @xClsColorCALLBACK;
	Module_entry_table[323].fname := 'xClearWorld';
	Module_entry_table[323].handler := @xClearWorldCALLBACK;
	Module_entry_table[324].fname := 'xColor';
	Module_entry_table[324].handler := @xColorCALLBACK;
	Module_entry_table[325].fname := 'xCls';
	Module_entry_table[325].handler := @xClsCALLBACK;
	Module_entry_table[326].fname := 'xUpdateWorld';
	Module_entry_table[326].handler := @xUpdateWorldCALLBACK;
	Module_entry_table[327].fname := 'xRenderEntity';
	Module_entry_table[327].handler := @xRenderEntityCALLBACK;
	Module_entry_table[328].fname := 'xRenderWorld';
	Module_entry_table[328].handler := @xRenderWorldCALLBACK;
	Module_entry_table[329].fname := 'xSetAutoTB';
	Module_entry_table[329].handler := @xSetAutoTBCALLBACK;
	Module_entry_table[330].fname := 'xMaxClipPlanes';
	Module_entry_table[330].handler := @xMaxClipPlanesCALLBACK;
	Module_entry_table[331].fname := 'xWireframe';
	Module_entry_table[331].handler := @xWireframeCALLBACK;
	Module_entry_table[332].fname := 'xDither';
	Module_entry_table[332].handler := @xDitherCALLBACK;
	Module_entry_table[333].fname := 'xSetSkinningMethod';
	Module_entry_table[333].handler := @xSetSkinningMethodCALLBACK;
	Module_entry_table[334].fname := 'xTrisRendered';
	Module_entry_table[334].handler := @xTrisRenderedCALLBACK;
	Module_entry_table[335].fname := 'xDIPCounter';
	Module_entry_table[335].handler := @xDIPCounterCALLBACK;
	Module_entry_table[336].fname := 'xSurfRendered';
	Module_entry_table[336].handler := @xSurfRenderedCALLBACK;
	Module_entry_table[337].fname := 'xEntityRendered';
	Module_entry_table[337].handler := @xEntityRenderedCALLBACK;
	Module_entry_table[338].fname := 'xAmbientLight';
	Module_entry_table[338].handler := @xAmbientLightCALLBACK;
	Module_entry_table[339].fname := 'xGetFPS';
	Module_entry_table[339].handler := @xGetFPSCALLBACK;
	Module_entry_table[340].fname := 'xAntiAlias';
	Module_entry_table[340].handler := @xAntiAliasCALLBACK;
	Module_entry_table[341].fname := 'xSetTextureFiltering';
	Module_entry_table[341].handler := @xSetTextureFilteringCALLBACK;
	Module_entry_table[342].fname := 'xStretchRect';
	Module_entry_table[342].handler := @xStretchRectCALLBACK;
	Module_entry_table[343].fname := 'xStretchBackBuffer';
	Module_entry_table[343].handler := @xStretchBackBufferCALLBACK;
	Module_entry_table[344].fname := 'xGetDevice';
	Module_entry_table[344].handler := @xGetDeviceCALLBACK;
	Module_entry_table[345].fname := 'xReleaseGraphics';
	Module_entry_table[345].handler := @xReleaseGraphicsCALLBACK;
	Module_entry_table[346].fname := 'xShowPointer';
	Module_entry_table[346].handler := @xShowPointerCALLBACK;
	Module_entry_table[347].fname := 'xHidePointer';
	Module_entry_table[347].handler := @xHidePointerCALLBACK;
	Module_entry_table[348].fname := 'xCreateDSS';
	Module_entry_table[348].handler := @xCreateDSSCALLBACK;
	Module_entry_table[349].fname := 'xDeleteDSS';
	Module_entry_table[349].handler := @xDeleteDSSCALLBACK;
	Module_entry_table[350].fname := 'xGridColor';
	Module_entry_table[350].handler := @xGridColorCALLBACK;
	Module_entry_table[351].fname := 'xDrawGrid';
	Module_entry_table[351].handler := @xDrawGridCALLBACK;
	Module_entry_table[352].fname := 'xDrawBBox';
	Module_entry_table[352].handler := @xDrawBBoxCALLBACK;
	Module_entry_table[353].fname := 'xGraphics3D';
	Module_entry_table[353].handler := @xGraphics3DCALLBACK;
	Module_entry_table[354].fname := 'xGraphicsAspectRatio';
	Module_entry_table[354].handler := @xGraphicsAspectRatioCALLBACK;
	Module_entry_table[355].fname := 'xGraphicsBorderColor';
	Module_entry_table[355].handler := @xGraphicsBorderColorCALLBACK;
	Module_entry_table[356].fname := 'xGetRenderWindow';
	Module_entry_table[356].handler := @xGetRenderWindowCALLBACK;
	Module_entry_table[357].fname := 'xKey';
	Module_entry_table[357].handler := @xKeyCALLBACK;
	Module_entry_table[358].fname := 'xSetEngineSetting';
	Module_entry_table[358].handler := @xSetEngineSettingCALLBACK;
	Module_entry_table[359].fname := 'xGetEngineSetting';
	Module_entry_table[359].handler := @xGetEngineSettingCALLBACK;
	Module_entry_table[360].fname := 'xHWInstancingAvailable';
	Module_entry_table[360].handler := @xHWInstancingAvailableCALLBACK;
	Module_entry_table[361].fname := 'xShaderInstancingAvailable';
	Module_entry_table[361].handler := @xShaderInstancingAvailableCALLBACK;
	Module_entry_table[362].fname := 'xSetShaderLayer';
	Module_entry_table[362].handler := @xSetShaderLayerCALLBACK;
	Module_entry_table[363].fname := 'xGetShaderLayer';
	Module_entry_table[363].handler := @xGetShaderLayerCALLBACK;
	Module_entry_table[364].fname := 'xDrawMovementGizmo';
	Module_entry_table[364].handler := @xDrawMovementGizmoCALLBACK;
	Module_entry_table[365].fname := 'xDrawScaleGizmo';
	Module_entry_table[365].handler := @xDrawScaleGizmoCALLBACK;
	Module_entry_table[366].fname := 'xDrawRotationGizmo';
	Module_entry_table[366].handler := @xDrawRotationGizmoCALLBACK;
	Module_entry_table[367].fname := 'xCheckMovementGizmo';
	Module_entry_table[367].handler := @xCheckMovementGizmoCALLBACK;
	Module_entry_table[368].fname := 'xCheckScaleGizmo';
	Module_entry_table[368].handler := @xCheckScaleGizmoCALLBACK;
	Module_entry_table[369].fname := 'xCheckRotationGizmo';
	Module_entry_table[369].handler := @xCheckRotationGizmoCALLBACK;
	Module_entry_table[370].fname := 'xCaptureWorld';
	Module_entry_table[370].handler := @xCaptureWorldCALLBACK;
	Module_entry_table[371].fname := 'xCountGfxModes';
	Module_entry_table[371].handler := @xCountGfxModesCALLBACK;
	Module_entry_table[372].fname := 'xGfxModeWidth';
	Module_entry_table[372].handler := @xGfxModeWidthCALLBACK;
	Module_entry_table[373].fname := 'xGfxModeHeight';
	Module_entry_table[373].handler := @xGfxModeHeightCALLBACK;
	Module_entry_table[374].fname := 'xGfxModeDepth';
	Module_entry_table[374].handler := @xGfxModeDepthCALLBACK;
	Module_entry_table[375].fname := 'xGfxModeExists';
	Module_entry_table[375].handler := @xGfxModeExistsCALLBACK;
	Module_entry_table[376].fname := 'xAppWindowFrame';
	Module_entry_table[376].handler := @xAppWindowFrameCALLBACK;
	Module_entry_table[377].fname := 'xMillisecs';
	Module_entry_table[377].handler := @xMillisecsCALLBACK;
	Module_entry_table[378].fname := 'xDeltaTime';
	Module_entry_table[378].handler := @xDeltaTimeCALLBACK;
	Module_entry_table[379].fname := 'xDeltaValue';
	Module_entry_table[379].handler := @xDeltaValueCALLBACK;
	Module_entry_table[380].fname := 'xAddDeviceLostCallback';
	Module_entry_table[380].handler := @xAddDeviceLostCallbackCALLBACK;
	Module_entry_table[381].fname := 'xDeleteDeviceLostCallback';
	Module_entry_table[381].handler := @xDeleteDeviceLostCallbackCALLBACK;
	Module_entry_table[382].fname := 'xImageColor';
	Module_entry_table[382].handler := @xImageColorCALLBACK;
	Module_entry_table[383].fname := 'xImageAlpha';
	Module_entry_table[383].handler := @xImageAlphaCALLBACK;
	Module_entry_table[384].fname := 'xImageBuffer';
	Module_entry_table[384].handler := @xImageBufferCALLBACK;
	Module_entry_table[385].fname := 'xCreateImage';
	Module_entry_table[385].handler := @xCreateImageCALLBACK;
	Module_entry_table[386].fname := 'xGrabImage';
	Module_entry_table[386].handler := @xGrabImageCALLBACK;
	Module_entry_table[387].fname := 'xFreeImage';
	Module_entry_table[387].handler := @xFreeImageCALLBACK;
	Module_entry_table[388].fname := 'xLoadImage';
	Module_entry_table[388].handler := @xLoadImageCALLBACK;
	Module_entry_table[389].fname := 'xLoadAnimImage';
	Module_entry_table[389].handler := @xLoadAnimImageCALLBACK;
	Module_entry_table[390].fname := 'xSaveImage';
	Module_entry_table[390].handler := @xSaveImageCALLBACK;
	Module_entry_table[391].fname := 'xDrawImage';
	Module_entry_table[391].handler := @xDrawImageCALLBACK;
	Module_entry_table[392].fname := 'xDrawImageRect';
	Module_entry_table[392].handler := @xDrawImageRectCALLBACK;
	Module_entry_table[393].fname := 'xScaleImage';
	Module_entry_table[393].handler := @xScaleImageCALLBACK;
	Module_entry_table[394].fname := 'xResizeImage';
	Module_entry_table[394].handler := @xResizeImageCALLBACK;
	Module_entry_table[395].fname := 'xRotateImage';
	Module_entry_table[395].handler := @xRotateImageCALLBACK;
	Module_entry_table[396].fname := 'xImageAngle';
	Module_entry_table[396].handler := @xImageAngleCALLBACK;
	Module_entry_table[397].fname := 'xImageWidth';
	Module_entry_table[397].handler := @xImageWidthCALLBACK;
	Module_entry_table[398].fname := 'xImageHeight';
	Module_entry_table[398].handler := @xImageHeightCALLBACK;
	Module_entry_table[399].fname := 'xImagesCollide';
	Module_entry_table[399].handler := @xImagesCollideCALLBACK;
	Module_entry_table[400].fname := 'xImageRectCollide';
	Module_entry_table[400].handler := @xImageRectCollideCALLBACK;
	Module_entry_table[401].fname := 'xImageRectOverlap';
	Module_entry_table[401].handler := @xImageRectOverlapCALLBACK;
	Module_entry_table[402].fname := 'xImageXHandle';
	Module_entry_table[402].handler := @xImageXHandleCALLBACK;
	Module_entry_table[403].fname := 'xImageYHandle';
	Module_entry_table[403].handler := @xImageYHandleCALLBACK;
	Module_entry_table[404].fname := 'xHandleImage';
	Module_entry_table[404].handler := @xHandleImageCALLBACK;
	Module_entry_table[405].fname := 'xMidHandle';
	Module_entry_table[405].handler := @xMidHandleCALLBACK;
	Module_entry_table[406].fname := 'xAutoMidHandle';
	Module_entry_table[406].handler := @xAutoMidHandleCALLBACK;
	Module_entry_table[407].fname := 'xTileImage';
	Module_entry_table[407].handler := @xTileImageCALLBACK;
	Module_entry_table[408].fname := 'xImagesOverlap';
	Module_entry_table[408].handler := @xImagesOverlapCALLBACK;
	Module_entry_table[409].fname := 'xMaskImage';
	Module_entry_table[409].handler := @xMaskImageCALLBACK;
	Module_entry_table[410].fname := 'xCopyImage';
	Module_entry_table[410].handler := @xCopyImageCALLBACK;
	Module_entry_table[411].fname := 'xDrawBlock';
	Module_entry_table[411].handler := @xDrawBlockCALLBACK;
	Module_entry_table[412].fname := 'xDrawBlockRect';
	Module_entry_table[412].handler := @xDrawBlockRectCALLBACK;
	Module_entry_table[413].fname := 'xImageActualWidth';
	Module_entry_table[413].handler := @xImageActualWidthCALLBACK;
	Module_entry_table[414].fname := 'xImageActualHeight';
	Module_entry_table[414].handler := @xImageActualHeightCALLBACK;
	Module_entry_table[415].fname := 'xFlushKeys';
	Module_entry_table[415].handler := @xFlushKeysCALLBACK;
	Module_entry_table[416].fname := 'xFlushMouse';
	Module_entry_table[416].handler := @xFlushMouseCALLBACK;
	Module_entry_table[417].fname := 'xKeyHit';
	Module_entry_table[417].handler := @xKeyHitCALLBACK;
	Module_entry_table[418].fname := 'xKeyUp';
	Module_entry_table[418].handler := @xKeyUpCALLBACK;
	Module_entry_table[419].fname := 'xWaitKey';
	Module_entry_table[419].handler := @xWaitKeyCALLBACK;
	Module_entry_table[420].fname := 'xMouseHit';
	Module_entry_table[420].handler := @xMouseHitCALLBACK;
	Module_entry_table[421].fname := 'xKeyDown';
	Module_entry_table[421].handler := @xKeyDownCALLBACK;
	Module_entry_table[422].fname := 'xGetKey';
	Module_entry_table[422].handler := @xGetKeyCALLBACK;
	Module_entry_table[423].fname := 'xMouseDown';
	Module_entry_table[423].handler := @xMouseDownCALLBACK;
	Module_entry_table[424].fname := 'xMouseUp';
	Module_entry_table[424].handler := @xMouseUpCALLBACK;
	Module_entry_table[425].fname := 'xGetMouse';
	Module_entry_table[425].handler := @xGetMouseCALLBACK;
	Module_entry_table[426].fname := 'xMouseX';
	Module_entry_table[426].handler := @xMouseXCALLBACK;
	Module_entry_table[427].fname := 'xMouseY';
	Module_entry_table[427].handler := @xMouseYCALLBACK;
	Module_entry_table[428].fname := 'xMouseZ';
	Module_entry_table[428].handler := @xMouseZCALLBACK;
	Module_entry_table[429].fname := 'xMouseXSpeed';
	Module_entry_table[429].handler := @xMouseXSpeedCALLBACK;
	Module_entry_table[430].fname := 'xMouseYSpeed';
	Module_entry_table[430].handler := @xMouseYSpeedCALLBACK;
	Module_entry_table[431].fname := 'xMouseZSpeed';
	Module_entry_table[431].handler := @xMouseZSpeedCALLBACK;
	Module_entry_table[432].fname := 'xMouseSpeed';
	Module_entry_table[432].handler := @xMouseSpeedCALLBACK;
	Module_entry_table[433].fname := 'xMoveMouse';
	Module_entry_table[433].handler := @xMoveMouseCALLBACK;
	Module_entry_table[434].fname := 'xJoyType';
	Module_entry_table[434].handler := @xJoyTypeCALLBACK;
	Module_entry_table[435].fname := 'xJoyDown';
	Module_entry_table[435].handler := @xJoyDownCALLBACK;
	Module_entry_table[436].fname := 'xJoyHit';
	Module_entry_table[436].handler := @xJoyHitCALLBACK;
	Module_entry_table[437].fname := 'xGetJoy';
	Module_entry_table[437].handler := @xGetJoyCALLBACK;
	Module_entry_table[438].fname := 'xFlushJoy';
	Module_entry_table[438].handler := @xFlushJoyCALLBACK;
	Module_entry_table[439].fname := 'xWaitJoy';
	Module_entry_table[439].handler := @xWaitJoyCALLBACK;
	Module_entry_table[440].fname := 'xJoyX';
	Module_entry_table[440].handler := @xJoyXCALLBACK;
	Module_entry_table[441].fname := 'xJoyY';
	Module_entry_table[441].handler := @xJoyYCALLBACK;
	Module_entry_table[442].fname := 'xJoyZ';
	Module_entry_table[442].handler := @xJoyZCALLBACK;
	Module_entry_table[443].fname := 'xJoyU';
	Module_entry_table[443].handler := @xJoyUCALLBACK;
	Module_entry_table[444].fname := 'xJoyV';
	Module_entry_table[444].handler := @xJoyVCALLBACK;
	Module_entry_table[445].fname := 'xJoyPitch';
	Module_entry_table[445].handler := @xJoyPitchCALLBACK;
	Module_entry_table[446].fname := 'xJoyYaw';
	Module_entry_table[446].handler := @xJoyYawCALLBACK;
	Module_entry_table[447].fname := 'xJoyRoll';
	Module_entry_table[447].handler := @xJoyRollCALLBACK;
	Module_entry_table[448].fname := 'xJoyHat';
	Module_entry_table[448].handler := @xJoyHatCALLBACK;
	Module_entry_table[449].fname := 'xJoyXDir';
	Module_entry_table[449].handler := @xJoyXDirCALLBACK;
	Module_entry_table[450].fname := 'xJoyYDir';
	Module_entry_table[450].handler := @xJoyYDirCALLBACK;
	Module_entry_table[451].fname := 'xJoyZDir';
	Module_entry_table[451].handler := @xJoyZDirCALLBACK;
	Module_entry_table[452].fname := 'xJoyUDir';
	Module_entry_table[452].handler := @xJoyUDirCALLBACK;
	Module_entry_table[453].fname := 'xJoyVDir';
	Module_entry_table[453].handler := @xJoyVDirCALLBACK;
	Module_entry_table[454].fname := 'xCreateLight';
	Module_entry_table[454].handler := @xCreateLightCALLBACK;
	Module_entry_table[455].fname := 'xLightShadowEpsilons';
	Module_entry_table[455].handler := @xLightShadowEpsilonsCALLBACK;
	Module_entry_table[456].fname := 'xLightEnableShadows';
	Module_entry_table[456].handler := @xLightEnableShadowsCALLBACK;
	Module_entry_table[457].fname := 'xLightShadowsEnabled';
	Module_entry_table[457].handler := @xLightShadowsEnabledCALLBACK;
	Module_entry_table[458].fname := 'xLightRange';
	Module_entry_table[458].handler := @xLightRangeCALLBACK;
	Module_entry_table[459].fname := 'xLightColor';
	Module_entry_table[459].handler := @xLightColorCALLBACK;
	Module_entry_table[460].fname := 'xLightConeAngles';
	Module_entry_table[460].handler := @xLightConeAnglesCALLBACK;
	Module_entry_table[461].fname := 'xCreateLog';
	Module_entry_table[461].handler := @xCreateLogCALLBACK;
	Module_entry_table[462].fname := 'xCloseLog';
	Module_entry_table[462].handler := @xCloseLogCALLBACK;
	Module_entry_table[463].fname := 'xGetLogString';
	Module_entry_table[463].handler := @xGetLogStringCALLBACK;
	Module_entry_table[464].fname := 'xClearLogString';
	Module_entry_table[464].handler := @xClearLogStringCALLBACK;
	Module_entry_table[465].fname := 'xSetLogLevel';
	Module_entry_table[465].handler := @xSetLogLevelCALLBACK;
	Module_entry_table[466].fname := 'xSetLogTarget';
	Module_entry_table[466].handler := @xSetLogTargetCALLBACK;
	Module_entry_table[467].fname := 'xGetLogLevel';
	Module_entry_table[467].handler := @xGetLogLevelCALLBACK;
	Module_entry_table[468].fname := 'xGetLogTarget';
	Module_entry_table[468].handler := @xGetLogTargetCALLBACK;
	Module_entry_table[469].fname := 'xLogInfo';
	Module_entry_table[469].handler := @xLogInfoCALLBACK;
	Module_entry_table[470].fname := 'xLogMessage';
	Module_entry_table[470].handler := @xLogMessageCALLBACK;
	Module_entry_table[471].fname := 'xLogWarning';
	Module_entry_table[471].handler := @xLogWarningCALLBACK;
	Module_entry_table[472].fname := 'xLogError';
	Module_entry_table[472].handler := @xLogErrorCALLBACK;
	Module_entry_table[473].fname := 'xLogFatal';
	Module_entry_table[473].handler := @xLogFatalCALLBACK;
	Module_entry_table[474].fname := 'xCreateMesh';
	Module_entry_table[474].handler := @xCreateMeshCALLBACK;
	Module_entry_table[475].fname := 'xLoadMesh';
	Module_entry_table[475].handler := @xLoadMeshCALLBACK;
	Module_entry_table[476].fname := 'xLoadMeshWithChild';
	Module_entry_table[476].handler := @xLoadMeshWithChildCALLBACK;
	Module_entry_table[477].fname := 'xLoadAnimMesh';
	Module_entry_table[477].handler := @xLoadAnimMeshCALLBACK;
	Module_entry_table[478].fname := 'xCreateCube';
	Module_entry_table[478].handler := @xCreateCubeCALLBACK;
	Module_entry_table[479].fname := 'xCreateSphere';
	Module_entry_table[479].handler := @xCreateSphereCALLBACK;
	Module_entry_table[480].fname := 'xCreateCylinder';
	Module_entry_table[480].handler := @xCreateCylinderCALLBACK;
	Module_entry_table[481].fname := 'xCreateTorus';
	Module_entry_table[481].handler := @xCreateTorusCALLBACK;
	Module_entry_table[482].fname := 'xCreateCone';
	Module_entry_table[482].handler := @xCreateConeCALLBACK;
	Module_entry_table[483].fname := 'xCopyMesh';
	Module_entry_table[483].handler := @xCopyMeshCALLBACK;
	Module_entry_table[484].fname := 'xAddMesh';
	Module_entry_table[484].handler := @xAddMeshCALLBACK;
	Module_entry_table[485].fname := 'xFlipMesh';
	Module_entry_table[485].handler := @xFlipMeshCALLBACK;
	Module_entry_table[486].fname := 'xPaintMesh';
	Module_entry_table[486].handler := @xPaintMeshCALLBACK;
	Module_entry_table[487].fname := 'xFitMesh';
	Module_entry_table[487].handler := @xFitMeshCALLBACK;
	Module_entry_table[488].fname := 'xMeshWidth';
	Module_entry_table[488].handler := @xMeshWidthCALLBACK;
	Module_entry_table[489].fname := 'xMeshHeight';
	Module_entry_table[489].handler := @xMeshHeightCALLBACK;
	Module_entry_table[490].fname := 'xMeshDepth';
	Module_entry_table[490].handler := @xMeshDepthCALLBACK;
	Module_entry_table[491].fname := 'xScaleMesh';
	Module_entry_table[491].handler := @xScaleMeshCALLBACK;
	Module_entry_table[492].fname := 'xRotateMesh';
	Module_entry_table[492].handler := @xRotateMeshCALLBACK;
	Module_entry_table[493].fname := 'xPositionMesh';
	Module_entry_table[493].handler := @xPositionMeshCALLBACK;
	Module_entry_table[494].fname := 'xUpdateNormals';
	Module_entry_table[494].handler := @xUpdateNormalsCALLBACK;
	Module_entry_table[495].fname := 'xUpdateN';
	Module_entry_table[495].handler := @xUpdateNCALLBACK;
	Module_entry_table[496].fname := 'xUpdateTB';
	Module_entry_table[496].handler := @xUpdateTBCALLBACK;
	Module_entry_table[497].fname := 'xMeshesBBIntersect';
	Module_entry_table[497].handler := @xMeshesBBIntersectCALLBACK;
	Module_entry_table[498].fname := 'xMeshesIntersect';
	Module_entry_table[498].handler := @xMeshesIntersectCALLBACK;
	Module_entry_table[499].fname := 'xGetMeshVB';
	Module_entry_table[499].handler := @xGetMeshVBCALLBACK;
	Module_entry_table[500].fname := 'xGetMeshIB';
	Module_entry_table[500].handler := @xGetMeshIBCALLBACK;
	Module_entry_table[501].fname := 'xGetMeshVBSize';
	Module_entry_table[501].handler := @xGetMeshVBSizeCALLBACK;
	Module_entry_table[502].fname := 'xGetMeshIBSize';
	Module_entry_table[502].handler := @xGetMeshIBSizeCALLBACK;
	Module_entry_table[503].fname := 'xDeleteMeshVB';
	Module_entry_table[503].handler := @xDeleteMeshVBCALLBACK;
	Module_entry_table[504].fname := 'xDeleteMeshIB';
	Module_entry_table[504].handler := @xDeleteMeshIBCALLBACK;
	Module_entry_table[505].fname := 'xCountSurfaces';
	Module_entry_table[505].handler := @xCountSurfacesCALLBACK;
	Module_entry_table[506].fname := 'xGetSurface';
	Module_entry_table[506].handler := @xGetSurfaceCALLBACK;
	Module_entry_table[507].fname := 'xCreatePivot';
	Module_entry_table[507].handler := @xCreatePivotCALLBACK;
	Module_entry_table[508].fname := 'xFindSurface';
	Module_entry_table[508].handler := @xFindSurfaceCALLBACK;
	Module_entry_table[509].fname := 'xCreatePoly';
	Module_entry_table[509].handler := @xCreatePolyCALLBACK;
	Module_entry_table[510].fname := 'xMeshSingleSurface';
	Module_entry_table[510].handler := @xMeshSingleSurfaceCALLBACK;
	Module_entry_table[511].fname := 'xSaveMesh';
	Module_entry_table[511].handler := @xSaveMeshCALLBACK;
	Module_entry_table[512].fname := 'xLightMesh';
	Module_entry_table[512].handler := @xLightMeshCALLBACK;
	Module_entry_table[513].fname := 'xMeshPrimitiveType';
	Module_entry_table[513].handler := @xMeshPrimitiveTypeCALLBACK;
	Module_entry_table[514].fname := 'xParticlePosition';
	Module_entry_table[514].handler := @xParticlePositionCALLBACK;
	Module_entry_table[515].fname := 'xParticleX';
	Module_entry_table[515].handler := @xParticleXCALLBACK;
	Module_entry_table[516].fname := 'xParticleY';
	Module_entry_table[516].handler := @xParticleYCALLBACK;
	Module_entry_table[517].fname := 'xParticleZ';
	Module_entry_table[517].handler := @xParticleZCALLBACK;
	Module_entry_table[518].fname := 'xParticleVeclocity';
	Module_entry_table[518].handler := @xParticleVeclocityCALLBACK;
	Module_entry_table[519].fname := 'xParticleVX';
	Module_entry_table[519].handler := @xParticleVXCALLBACK;
	Module_entry_table[520].fname := 'xParticleVY';
	Module_entry_table[520].handler := @xParticleVYCALLBACK;
	Module_entry_table[521].fname := 'xParticleVZ';
	Module_entry_table[521].handler := @xParticleVZCALLBACK;
	Module_entry_table[522].fname := 'xParticleRotation';
	Module_entry_table[522].handler := @xParticleRotationCALLBACK;
	Module_entry_table[523].fname := 'xParticlePitch';
	Module_entry_table[523].handler := @xParticlePitchCALLBACK;
	Module_entry_table[524].fname := 'xParticleYaw';
	Module_entry_table[524].handler := @xParticleYawCALLBACK;
	Module_entry_table[525].fname := 'xParticleRoll';
	Module_entry_table[525].handler := @xParticleRollCALLBACK;
	Module_entry_table[526].fname := 'xParticleTorque';
	Module_entry_table[526].handler := @xParticleTorqueCALLBACK;
	Module_entry_table[527].fname := 'xParticleTPitch';
	Module_entry_table[527].handler := @xParticleTPitchCALLBACK;
	Module_entry_table[528].fname := 'xParticleTYaw';
	Module_entry_table[528].handler := @xParticleTYawCALLBACK;
	Module_entry_table[529].fname := 'xParticleTRoll';
	Module_entry_table[529].handler := @xParticleTRollCALLBACK;
	Module_entry_table[530].fname := 'xParticleSetAlpha';
	Module_entry_table[530].handler := @xParticleSetAlphaCALLBACK;
	Module_entry_table[531].fname := 'xParticleGetAlpha';
	Module_entry_table[531].handler := @xParticleGetAlphaCALLBACK;
	Module_entry_table[532].fname := 'xParticleColor';
	Module_entry_table[532].handler := @xParticleColorCALLBACK;
	Module_entry_table[533].fname := 'xParticleRed';
	Module_entry_table[533].handler := @xParticleRedCALLBACK;
	Module_entry_table[534].fname := 'xParticleGreen';
	Module_entry_table[534].handler := @xParticleGreenCALLBACK;
	Module_entry_table[535].fname := 'xParticleBlue';
	Module_entry_table[535].handler := @xParticleBlueCALLBACK;
	Module_entry_table[536].fname := 'xParticleScale';
	Module_entry_table[536].handler := @xParticleScaleCALLBACK;
	Module_entry_table[537].fname := 'xParticleSX';
	Module_entry_table[537].handler := @xParticleSXCALLBACK;
	Module_entry_table[538].fname := 'xParticleSY';
	Module_entry_table[538].handler := @xParticleSYCALLBACK;
	Module_entry_table[539].fname := 'xParticleScaleSpeed';
	Module_entry_table[539].handler := @xParticleScaleSpeedCALLBACK;
	Module_entry_table[540].fname := 'xParticleScaleSpeedX';
	Module_entry_table[540].handler := @xParticleScaleSpeedXCALLBACK;
	Module_entry_table[541].fname := 'xParticleScaleSpeedY';
	Module_entry_table[541].handler := @xParticleScaleSpeedYCALLBACK;
	Module_entry_table[542].fname := 'xEntityAddDummyShape';
	Module_entry_table[542].handler := @xEntityAddDummyShapeCALLBACK;
	Module_entry_table[543].fname := 'xEntityAddBoxShape';
	Module_entry_table[543].handler := @xEntityAddBoxShapeCALLBACK;
	Module_entry_table[544].fname := 'xEntityAddSphereShape';
	Module_entry_table[544].handler := @xEntityAddSphereShapeCALLBACK;
	Module_entry_table[545].fname := 'xEntityAddCapsuleShape';
	Module_entry_table[545].handler := @xEntityAddCapsuleShapeCALLBACK;
	Module_entry_table[546].fname := 'xEntityAddConeShape';
	Module_entry_table[546].handler := @xEntityAddConeShapeCALLBACK;
	Module_entry_table[547].fname := 'xEntityAddCylinderShape';
	Module_entry_table[547].handler := @xEntityAddCylinderShapeCALLBACK;
	Module_entry_table[548].fname := 'xEntityAddTriMeshShape';
	Module_entry_table[548].handler := @xEntityAddTriMeshShapeCALLBACK;
	Module_entry_table[549].fname := 'xEntityAddHullShape';
	Module_entry_table[549].handler := @xEntityAddHullShapeCALLBACK;
	Module_entry_table[550].fname := 'xWorldGravity';
	Module_entry_table[550].handler := @xWorldGravityCALLBACK;
	Module_entry_table[551].fname := 'xWorldGravityX';
	Module_entry_table[551].handler := @xWorldGravityXCALLBACK;
	Module_entry_table[552].fname := 'xWorldGravityY';
	Module_entry_table[552].handler := @xWorldGravityYCALLBACK;
	Module_entry_table[553].fname := 'xWorldGravityZ';
	Module_entry_table[553].handler := @xWorldGravityZCALLBACK;
	Module_entry_table[554].fname := 'xWorldFrequency';
	Module_entry_table[554].handler := @xWorldFrequencyCALLBACK;
	Module_entry_table[555].fname := 'xEntityApplyCentralForce';
	Module_entry_table[555].handler := @xEntityApplyCentralForceCALLBACK;
	Module_entry_table[556].fname := 'xEntityApplyCentralImpulse';
	Module_entry_table[556].handler := @xEntityApplyCentralImpulseCALLBACK;
	Module_entry_table[557].fname := 'xEntityApplyTorque';
	Module_entry_table[557].handler := @xEntityApplyTorqueCALLBACK;
	Module_entry_table[558].fname := 'xEntityApplyTorqueImpulse';
	Module_entry_table[558].handler := @xEntityApplyTorqueImpulseCALLBACK;
	Module_entry_table[559].fname := 'xEntityApplyForce';
	Module_entry_table[559].handler := @xEntityApplyForceCALLBACK;
	Module_entry_table[560].fname := 'xEntityApplyImpulse';
	Module_entry_table[560].handler := @xEntityApplyImpulseCALLBACK;
	Module_entry_table[561].fname := 'xEntityReleaseForces';
	Module_entry_table[561].handler := @xEntityReleaseForcesCALLBACK;
	Module_entry_table[562].fname := 'xEntityDamping';
	Module_entry_table[562].handler := @xEntityDampingCALLBACK;
	Module_entry_table[563].fname := 'xGetEntityLinearDamping';
	Module_entry_table[563].handler := @xGetEntityLinearDampingCALLBACK;
	Module_entry_table[564].fname := 'xGetEntityAngularDamping';
	Module_entry_table[564].handler := @xGetEntityAngularDampingCALLBACK;
	Module_entry_table[565].fname := 'xEntityFriction';
	Module_entry_table[565].handler := @xEntityFrictionCALLBACK;
	Module_entry_table[566].fname := 'xGetEntityFriction';
	Module_entry_table[566].handler := @xGetEntityFrictionCALLBACK;
	Module_entry_table[567].fname := 'xEntityForceX';
	Module_entry_table[567].handler := @xEntityForceXCALLBACK;
	Module_entry_table[568].fname := 'xEntityForceY';
	Module_entry_table[568].handler := @xEntityForceYCALLBACK;
	Module_entry_table[569].fname := 'xEntityForceZ';
	Module_entry_table[569].handler := @xEntityForceZCALLBACK;
	Module_entry_table[570].fname := 'xEntityTorqueX';
	Module_entry_table[570].handler := @xEntityTorqueXCALLBACK;
	Module_entry_table[571].fname := 'xEntityTorqueY';
	Module_entry_table[571].handler := @xEntityTorqueYCALLBACK;
	Module_entry_table[572].fname := 'xEntityTorqueZ';
	Module_entry_table[572].handler := @xEntityTorqueZCALLBACK;
	Module_entry_table[573].fname := 'xFreeEntityShapes';
	Module_entry_table[573].handler := @xFreeEntityShapesCALLBACK;
	Module_entry_table[574].fname := 'xCountContacts';
	Module_entry_table[574].handler := @xCountContactsCALLBACK;
	Module_entry_table[575].fname := 'xEntityContactX';
	Module_entry_table[575].handler := @xEntityContactXCALLBACK;
	Module_entry_table[576].fname := 'xEntityContactY';
	Module_entry_table[576].handler := @xEntityContactYCALLBACK;
	Module_entry_table[577].fname := 'xEntityContactZ';
	Module_entry_table[577].handler := @xEntityContactZCALLBACK;
	Module_entry_table[578].fname := 'xEntityContactNX';
	Module_entry_table[578].handler := @xEntityContactNXCALLBACK;
	Module_entry_table[579].fname := 'xEntityContactNY';
	Module_entry_table[579].handler := @xEntityContactNYCALLBACK;
	Module_entry_table[580].fname := 'xEntityContactNZ';
	Module_entry_table[580].handler := @xEntityContactNZCALLBACK;
	Module_entry_table[581].fname := 'xEntityContactDistance';
	Module_entry_table[581].handler := @xEntityContactDistanceCALLBACK;
	Module_entry_table[582].fname := 'xContactEntity';
	Module_entry_table[582].handler := @xContactEntityCALLBACK;
	Module_entry_table[583].fname := 'xCreateJoint';
	Module_entry_table[583].handler := @xCreateJointCALLBACK;
	Module_entry_table[584].fname := 'xFreeJoint';
	Module_entry_table[584].handler := @xFreeJointCALLBACK;
	Module_entry_table[585].fname := 'xJointPivotA';
	Module_entry_table[585].handler := @xJointPivotACALLBACK;
	Module_entry_table[586].fname := 'xJointPivotB';
	Module_entry_table[586].handler := @xJointPivotBCALLBACK;
	Module_entry_table[587].fname := 'xJointPivotAX';
	Module_entry_table[587].handler := @xJointPivotAXCALLBACK;
	Module_entry_table[588].fname := 'xJointPivotAY';
	Module_entry_table[588].handler := @xJointPivotAYCALLBACK;
	Module_entry_table[589].fname := 'xJointPivotAZ';
	Module_entry_table[589].handler := @xJointPivotAZCALLBACK;
	Module_entry_table[590].fname := 'xJointPivotBX';
	Module_entry_table[590].handler := @xJointPivotBXCALLBACK;
	Module_entry_table[591].fname := 'xJointPivotBY';
	Module_entry_table[591].handler := @xJointPivotBYCALLBACK;
	Module_entry_table[592].fname := 'xJointPivotBZ';
	Module_entry_table[592].handler := @xJointPivotBZCALLBACK;
	Module_entry_table[593].fname := 'xJointLinearLimits';
	Module_entry_table[593].handler := @xJointLinearLimitsCALLBACK;
	Module_entry_table[594].fname := 'xJointAngularLimits';
	Module_entry_table[594].handler := @xJointAngularLimitsCALLBACK;
	Module_entry_table[595].fname := 'xJointLinearLowerX';
	Module_entry_table[595].handler := @xJointLinearLowerXCALLBACK;
	Module_entry_table[596].fname := 'xJointLinearLowerY';
	Module_entry_table[596].handler := @xJointLinearLowerYCALLBACK;
	Module_entry_table[597].fname := 'xJointLinearLowerZ';
	Module_entry_table[597].handler := @xJointLinearLowerZCALLBACK;
	Module_entry_table[598].fname := 'xJointLinearUpperX';
	Module_entry_table[598].handler := @xJointLinearUpperXCALLBACK;
	Module_entry_table[599].fname := 'xJointLinearUpperY';
	Module_entry_table[599].handler := @xJointLinearUpperYCALLBACK;
	Module_entry_table[600].fname := 'xJointLinearUpperZ';
	Module_entry_table[600].handler := @xJointLinearUpperZCALLBACK;
	Module_entry_table[601].fname := 'xJointAngularLowerX';
	Module_entry_table[601].handler := @xJointAngularLowerXCALLBACK;
	Module_entry_table[602].fname := 'xJointAngularLowerY';
	Module_entry_table[602].handler := @xJointAngularLowerYCALLBACK;
	Module_entry_table[603].fname := 'xJointAngularLowerZ';
	Module_entry_table[603].handler := @xJointAngularLowerZCALLBACK;
	Module_entry_table[604].fname := 'xJointAngularUpperX';
	Module_entry_table[604].handler := @xJointAngularUpperXCALLBACK;
	Module_entry_table[605].fname := 'xJointAngularUpperY';
	Module_entry_table[605].handler := @xJointAngularUpperYCALLBACK;
	Module_entry_table[606].fname := 'xJointAngularUpperZ';
	Module_entry_table[606].handler := @xJointAngularUpperZCALLBACK;
	Module_entry_table[607].fname := 'xJoint6dofSpringParam';
	Module_entry_table[607].handler := @xJoint6dofSpringParamCALLBACK;
	Module_entry_table[608].fname := 'xJointHingeAxis';
	Module_entry_table[608].handler := @xJointHingeAxisCALLBACK;
	Module_entry_table[609].fname := 'xJointHingeLimit';
	Module_entry_table[609].handler := @xJointHingeLimitCALLBACK;
	Module_entry_table[610].fname := 'xJointHingeLowerLimit';
	Module_entry_table[610].handler := @xJointHingeLowerLimitCALLBACK;
	Module_entry_table[611].fname := 'xJointHingeUpperLimit';
	Module_entry_table[611].handler := @xJointHingeUpperLimitCALLBACK;
	Module_entry_table[612].fname := 'xJointEnableMotor';
	Module_entry_table[612].handler := @xJointEnableMotorCALLBACK;
	Module_entry_table[613].fname := 'xJointHingeMotorTarget';
	Module_entry_table[613].handler := @xJointHingeMotorTargetCALLBACK;
	Module_entry_table[614].fname := 'xEntityLinearFactor';
	Module_entry_table[614].handler := @xEntityLinearFactorCALLBACK;
	Module_entry_table[615].fname := 'xEntityLinearFactorX';
	Module_entry_table[615].handler := @xEntityLinearFactorXCALLBACK;
	Module_entry_table[616].fname := 'xEntityLinearFactorY';
	Module_entry_table[616].handler := @xEntityLinearFactorYCALLBACK;
	Module_entry_table[617].fname := 'xEntityLinearFactorZ';
	Module_entry_table[617].handler := @xEntityLinearFactorZCALLBACK;
	Module_entry_table[618].fname := 'xEntityAngularFactor';
	Module_entry_table[618].handler := @xEntityAngularFactorCALLBACK;
	Module_entry_table[619].fname := 'xEntityAngularFactorX';
	Module_entry_table[619].handler := @xEntityAngularFactorXCALLBACK;
	Module_entry_table[620].fname := 'xEntityAngularFactorY';
	Module_entry_table[620].handler := @xEntityAngularFactorYCALLBACK;
	Module_entry_table[621].fname := 'xEntityAngularFactorZ';
	Module_entry_table[621].handler := @xEntityAngularFactorZCALLBACK;
	Module_entry_table[622].fname := 'xEntityGravity';
	Module_entry_table[622].handler := @xEntityGravityCALLBACK;
	Module_entry_table[623].fname := 'xEntityGravityX';
	Module_entry_table[623].handler := @xEntityGravityXCALLBACK;
	Module_entry_table[624].fname := 'xEntityGravityY';
	Module_entry_table[624].handler := @xEntityGravityYCALLBACK;
	Module_entry_table[625].fname := 'xEntityGravityZ';
	Module_entry_table[625].handler := @xEntityGravityZCALLBACK;
	Module_entry_table[626].fname := 'xPhysicsDebugRender';
	Module_entry_table[626].handler := @xPhysicsDebugRenderCALLBACK;
	Module_entry_table[627].fname := 'xLoadPostEffect';
	Module_entry_table[627].handler := @xLoadPostEffectCALLBACK;
	Module_entry_table[628].fname := 'xFreePostEffect';
	Module_entry_table[628].handler := @xFreePostEffectCALLBACK;
	Module_entry_table[629].fname := 'xSetPostEffect';
	Module_entry_table[629].handler := @xSetPostEffectCALLBACK;
	Module_entry_table[630].fname := 'xRenderPostEffects';
	Module_entry_table[630].handler := @xRenderPostEffectsCALLBACK;
	Module_entry_table[631].fname := 'xSetPostEffectInt';
	Module_entry_table[631].handler := @xSetPostEffectIntCALLBACK;
	Module_entry_table[632].fname := 'xSetPostEffectFloat';
	Module_entry_table[632].handler := @xSetPostEffectFloatCALLBACK;
	Module_entry_table[633].fname := 'xSetPostEffectBool';
	Module_entry_table[633].handler := @xSetPostEffectBoolCALLBACK;
	Module_entry_table[634].fname := 'xSetPostEffectVector';
	Module_entry_table[634].handler := @xSetPostEffectVectorCALLBACK;
	Module_entry_table[635].fname := 'xSetPostEffectTexture';
	Module_entry_table[635].handler := @xSetPostEffectTextureCALLBACK;
	Module_entry_table[636].fname := 'xDeletePostEffectConstant';
	Module_entry_table[636].handler := @xDeletePostEffectConstantCALLBACK;
	Module_entry_table[637].fname := 'xClearPostEffectConstants';
	Module_entry_table[637].handler := @xClearPostEffectConstantsCALLBACK;
	Module_entry_table[638].fname := 'xCreatePSystem';
	Module_entry_table[638].handler := @xCreatePSystemCALLBACK;
	Module_entry_table[639].fname := 'xPSystemType';
	Module_entry_table[639].handler := @xPSystemTypeCALLBACK;
	Module_entry_table[640].fname := 'xPSystemSetBlend';
	Module_entry_table[640].handler := @xPSystemSetBlendCALLBACK;
	Module_entry_table[641].fname := 'xPSystemGetBlend';
	Module_entry_table[641].handler := @xPSystemGetBlendCALLBACK;
	Module_entry_table[642].fname := 'xPSystemSetMaxParticles';
	Module_entry_table[642].handler := @xPSystemSetMaxParticlesCALLBACK;
	Module_entry_table[643].fname := 'xPSystemGetMaxParticles';
	Module_entry_table[643].handler := @xPSystemGetMaxParticlesCALLBACK;
	Module_entry_table[644].fname := 'xPSystemSetEmitterLifetime';
	Module_entry_table[644].handler := @xPSystemSetEmitterLifetimeCALLBACK;
	Module_entry_table[645].fname := 'xPSystemGetEmitterLifetime';
	Module_entry_table[645].handler := @xPSystemGetEmitterLifetimeCALLBACK;
	Module_entry_table[646].fname := 'xPSystemSetParticleLifetime';
	Module_entry_table[646].handler := @xPSystemSetParticleLifetimeCALLBACK;
	Module_entry_table[647].fname := 'xPSystemGetParticleLifetime';
	Module_entry_table[647].handler := @xPSystemGetParticleLifetimeCALLBACK;
	Module_entry_table[648].fname := 'xPSystemSetCreationInterval';
	Module_entry_table[648].handler := @xPSystemSetCreationIntervalCALLBACK;
	Module_entry_table[649].fname := 'xPSystemGetCreationInterval';
	Module_entry_table[649].handler := @xPSystemGetCreationIntervalCALLBACK;
	Module_entry_table[650].fname := 'xPSystemSetCreationFrequency';
	Module_entry_table[650].handler := @xPSystemSetCreationFrequencyCALLBACK;
	Module_entry_table[651].fname := 'xPSystemGetCreationFrequency';
	Module_entry_table[651].handler := @xPSystemGetCreationFrequencyCALLBACK;
	Module_entry_table[652].fname := 'xPSystemSetTexture';
	Module_entry_table[652].handler := @xPSystemSetTextureCALLBACK;
	Module_entry_table[653].fname := 'xPSystemGetTexture';
	Module_entry_table[653].handler := @xPSystemGetTextureCALLBACK;
	Module_entry_table[654].fname := 'xPSystemGetTextureFrames';
	Module_entry_table[654].handler := @xPSystemGetTextureFramesCALLBACK;
	Module_entry_table[655].fname := 'xPSystemGetTextureAnimationSpeed';
	Module_entry_table[655].handler := @xPSystemGetTextureAnimationSpeedCALLBACK;
	Module_entry_table[656].fname := 'xPSystemSetOffset';
	Module_entry_table[656].handler := @xPSystemSetOffsetCALLBACK;
	Module_entry_table[657].fname := 'xPSystemGetOffsetMinX';
	Module_entry_table[657].handler := @xPSystemGetOffsetMinXCALLBACK;
	Module_entry_table[658].fname := 'xPSystemGetOffsetMinY';
	Module_entry_table[658].handler := @xPSystemGetOffsetMinYCALLBACK;
	Module_entry_table[659].fname := 'xPSystemGetOffsetMinZ';
	Module_entry_table[659].handler := @xPSystemGetOffsetMinZCALLBACK;
	Module_entry_table[660].fname := 'xPSystemGetOffsetMaxX';
	Module_entry_table[660].handler := @xPSystemGetOffsetMaxXCALLBACK;
	Module_entry_table[661].fname := 'xPSystemGetOffsetMaxY';
	Module_entry_table[661].handler := @xPSystemGetOffsetMaxYCALLBACK;
	Module_entry_table[662].fname := 'xPSystemGetOffsetMaxZ';
	Module_entry_table[662].handler := @xPSystemGetOffsetMaxZCALLBACK;
	Module_entry_table[663].fname := 'xPSystemSetVelocity';
	Module_entry_table[663].handler := @xPSystemSetVelocityCALLBACK;
	Module_entry_table[664].fname := 'xPSystemGetVelocityMinX';
	Module_entry_table[664].handler := @xPSystemGetVelocityMinXCALLBACK;
	Module_entry_table[665].fname := 'xPSystemGetVelocityMinY';
	Module_entry_table[665].handler := @xPSystemGetVelocityMinYCALLBACK;
	Module_entry_table[666].fname := 'xPSystemGetVelocityMinZ';
	Module_entry_table[666].handler := @xPSystemGetVelocityMinZCALLBACK;
	Module_entry_table[667].fname := 'xPSystemGetVelocityMaxX';
	Module_entry_table[667].handler := @xPSystemGetVelocityMaxXCALLBACK;
	Module_entry_table[668].fname := 'xPSystemGetVelocityMaxY';
	Module_entry_table[668].handler := @xPSystemGetVelocityMaxYCALLBACK;
	Module_entry_table[669].fname := 'xPSystemGetVelocityMaxZ';
	Module_entry_table[669].handler := @xPSystemGetVelocityMaxZCALLBACK;
	Module_entry_table[670].fname := 'xPSystemEnableFixedQuads';
	Module_entry_table[670].handler := @xPSystemEnableFixedQuadsCALLBACK;
	Module_entry_table[671].fname := 'xPSystemFixedQuadsUsed';
	Module_entry_table[671].handler := @xPSystemFixedQuadsUsedCALLBACK;
	Module_entry_table[672].fname := 'xPSystemSetTorque';
	Module_entry_table[672].handler := @xPSystemSetTorqueCALLBACK;
	Module_entry_table[673].fname := 'xPSystemGetTorqueMinX';
	Module_entry_table[673].handler := @xPSystemGetTorqueMinXCALLBACK;
	Module_entry_table[674].fname := 'xPSystemGetTorqueMinY';
	Module_entry_table[674].handler := @xPSystemGetTorqueMinYCALLBACK;
	Module_entry_table[675].fname := 'xPSystemGetTorqueMinZ';
	Module_entry_table[675].handler := @xPSystemGetTorqueMinZCALLBACK;
	Module_entry_table[676].fname := 'xPSystemGetTorqueMaxX';
	Module_entry_table[676].handler := @xPSystemGetTorqueMaxXCALLBACK;
	Module_entry_table[677].fname := 'xPSystemGetTorqueMaxY';
	Module_entry_table[677].handler := @xPSystemGetTorqueMaxYCALLBACK;
	Module_entry_table[678].fname := 'xPSystemGetTorqueMaxZ';
	Module_entry_table[678].handler := @xPSystemGetTorqueMaxZCALLBACK;
	Module_entry_table[679].fname := 'xPSystemSetGravity';
	Module_entry_table[679].handler := @xPSystemSetGravityCALLBACK;
	Module_entry_table[680].fname := 'xPSystemGetGravity';
	Module_entry_table[680].handler := @xPSystemGetGravityCALLBACK;
	Module_entry_table[681].fname := 'xPSystemSetAlpha';
	Module_entry_table[681].handler := @xPSystemSetAlphaCALLBACK;
	Module_entry_table[682].fname := 'xPSystemGetAlpha';
	Module_entry_table[682].handler := @xPSystemGetAlphaCALLBACK;
	Module_entry_table[683].fname := 'xPSystemSetFadeSpeed';
	Module_entry_table[683].handler := @xPSystemSetFadeSpeedCALLBACK;
	Module_entry_table[684].fname := 'xPSystemGetFadeSpeed';
	Module_entry_table[684].handler := @xPSystemGetFadeSpeedCALLBACK;
	Module_entry_table[685].fname := 'xPSystemSetParticleSize';
	Module_entry_table[685].handler := @xPSystemSetParticleSizeCALLBACK;
	Module_entry_table[686].fname := 'xPSystemGetSizeMinX';
	Module_entry_table[686].handler := @xPSystemGetSizeMinXCALLBACK;
	Module_entry_table[687].fname := 'xPSystemGetSizeMinY';
	Module_entry_table[687].handler := @xPSystemGetSizeMinYCALLBACK;
	Module_entry_table[688].fname := 'xPSystemGetSizeMaxX';
	Module_entry_table[688].handler := @xPSystemGetSizeMaxXCALLBACK;
	Module_entry_table[689].fname := 'xPSystemGetSizeMaxY';
	Module_entry_table[689].handler := @xPSystemGetSizeMaxYCALLBACK;
	Module_entry_table[690].fname := 'xPSystemSetScaleSpeed';
	Module_entry_table[690].handler := @xPSystemSetScaleSpeedCALLBACK;
	Module_entry_table[691].fname := 'xPSystemGetScaleSpeedMinX';
	Module_entry_table[691].handler := @xPSystemGetScaleSpeedMinXCALLBACK;
	Module_entry_table[692].fname := 'xPSystemGetScaleSpeedMinY';
	Module_entry_table[692].handler := @xPSystemGetScaleSpeedMinYCALLBACK;
	Module_entry_table[693].fname := 'xPSystemGetScaleSpeedMaxX';
	Module_entry_table[693].handler := @xPSystemGetScaleSpeedMaxXCALLBACK;
	Module_entry_table[694].fname := 'xPSystemGetScaleSpeedMaxY';
	Module_entry_table[694].handler := @xPSystemGetScaleSpeedMaxYCALLBACK;
	Module_entry_table[695].fname := 'xPSystemSetAngles';
	Module_entry_table[695].handler := @xPSystemSetAnglesCALLBACK;
	Module_entry_table[696].fname := 'xPSystemGetAnglesMinX';
	Module_entry_table[696].handler := @xPSystemGetAnglesMinXCALLBACK;
	Module_entry_table[697].fname := 'xPSystemGetAnglesMinY';
	Module_entry_table[697].handler := @xPSystemGetAnglesMinYCALLBACK;
	Module_entry_table[698].fname := 'xPSystemGetAnglesMinZ';
	Module_entry_table[698].handler := @xPSystemGetAnglesMinZCALLBACK;
	Module_entry_table[699].fname := 'xPSystemGetAnglesMaxX';
	Module_entry_table[699].handler := @xPSystemGetAnglesMaxXCALLBACK;
	Module_entry_table[700].fname := 'xPSystemGetAnglesMaxY';
	Module_entry_table[700].handler := @xPSystemGetAnglesMaxYCALLBACK;
	Module_entry_table[701].fname := 'xPSystemGetAnglesMaxZ';
	Module_entry_table[701].handler := @xPSystemGetAnglesMaxZCALLBACK;
	Module_entry_table[702].fname := 'xPSystemSetColorMode';
	Module_entry_table[702].handler := @xPSystemSetColorModeCALLBACK;
	Module_entry_table[703].fname := 'xPSystemGetColorMode';
	Module_entry_table[703].handler := @xPSystemGetColorModeCALLBACK;
	Module_entry_table[704].fname := 'xPSystemSetColors';
	Module_entry_table[704].handler := @xPSystemSetColorsCALLBACK;
	Module_entry_table[705].fname := 'xPSystemGetBeginColorRed';
	Module_entry_table[705].handler := @xPSystemGetBeginColorRedCALLBACK;
	Module_entry_table[706].fname := 'xPSystemGetBeginColorGreen';
	Module_entry_table[706].handler := @xPSystemGetBeginColorGreenCALLBACK;
	Module_entry_table[707].fname := 'xPSystemGetBeginColorBlue';
	Module_entry_table[707].handler := @xPSystemGetBeginColorBlueCALLBACK;
	Module_entry_table[708].fname := 'xPSystemGetEndColorRed';
	Module_entry_table[708].handler := @xPSystemGetEndColorRedCALLBACK;
	Module_entry_table[709].fname := 'xPSystemGetEndColorGreen';
	Module_entry_table[709].handler := @xPSystemGetEndColorGreenCALLBACK;
	Module_entry_table[710].fname := 'xPSystemGetEndColorBlue';
	Module_entry_table[710].handler := @xPSystemGetEndColorBlueCALLBACK;
	Module_entry_table[711].fname := 'xFreePSystem';
	Module_entry_table[711].handler := @xFreePSystemCALLBACK;
	Module_entry_table[712].fname := 'xPSystemSetParticleParenting';
	Module_entry_table[712].handler := @xPSystemSetParticleParentingCALLBACK;
	Module_entry_table[713].fname := 'xPSystemGetParticleParenting';
	Module_entry_table[713].handler := @xPSystemGetParticleParentingCALLBACK;
	Module_entry_table[714].fname := 'xLinePick';
	Module_entry_table[714].handler := @xLinePickCALLBACK;
	Module_entry_table[715].fname := 'xEntityPick';
	Module_entry_table[715].handler := @xEntityPickCALLBACK;
	Module_entry_table[716].fname := 'xCameraPick';
	Module_entry_table[716].handler := @xCameraPickCALLBACK;
	Module_entry_table[717].fname := 'xPickedNX';
	Module_entry_table[717].handler := @xPickedNXCALLBACK;
	Module_entry_table[718].fname := 'xPickedNY';
	Module_entry_table[718].handler := @xPickedNYCALLBACK;
	Module_entry_table[719].fname := 'xPickedNZ';
	Module_entry_table[719].handler := @xPickedNZCALLBACK;
	Module_entry_table[720].fname := 'xPickedX';
	Module_entry_table[720].handler := @xPickedXCALLBACK;
	Module_entry_table[721].fname := 'xPickedY';
	Module_entry_table[721].handler := @xPickedYCALLBACK;
	Module_entry_table[722].fname := 'xPickedZ';
	Module_entry_table[722].handler := @xPickedZCALLBACK;
	Module_entry_table[723].fname := 'xPickedEntity';
	Module_entry_table[723].handler := @xPickedEntityCALLBACK;
	Module_entry_table[724].fname := 'xPickedSurface';
	Module_entry_table[724].handler := @xPickedSurfaceCALLBACK;
	Module_entry_table[725].fname := 'xPickedTriangle';
	Module_entry_table[725].handler := @xPickedTriangleCALLBACK;
	Module_entry_table[726].fname := 'xPickedTime';
	Module_entry_table[726].handler := @xPickedTimeCALLBACK;
	Module_entry_table[727].fname := 'xSetShadowsBlur';
	Module_entry_table[727].handler := @xSetShadowsBlurCALLBACK;
	Module_entry_table[728].fname := 'xSetShadowShader';
	Module_entry_table[728].handler := @xSetShadowShaderCALLBACK;
	Module_entry_table[729].fname := 'xInitShadows';
	Module_entry_table[729].handler := @xInitShadowsCALLBACK;
	Module_entry_table[730].fname := 'xSetShadowParams';
	Module_entry_table[730].handler := @xSetShadowParamsCALLBACK;
	Module_entry_table[731].fname := 'xRenderShadows';
	Module_entry_table[731].handler := @xRenderShadowsCALLBACK;
	Module_entry_table[732].fname := 'xShadowPriority';
	Module_entry_table[732].handler := @xShadowPriorityCALLBACK;
	Module_entry_table[733].fname := 'xCameraDisableShadows';
	Module_entry_table[733].handler := @xCameraDisableShadowsCALLBACK;
	Module_entry_table[734].fname := 'xCameraEnableShadows';
	Module_entry_table[734].handler := @xCameraEnableShadowsCALLBACK;
	Module_entry_table[735].fname := 'xEntityCastShadows';
	Module_entry_table[735].handler := @xEntityCastShadowsCALLBACK;
	Module_entry_table[736].fname := 'xEntityReceiveShadows';
	Module_entry_table[736].handler := @xEntityReceiveShadowsCALLBACK;
	Module_entry_table[737].fname := 'xEntityIsCaster';
	Module_entry_table[737].handler := @xEntityIsCasterCALLBACK;
	Module_entry_table[738].fname := 'xEntityIsReceiver';
	Module_entry_table[738].handler := @xEntityIsReceiverCALLBACK;
	Module_entry_table[739].fname := 'xLoadSound';
	Module_entry_table[739].handler := @xLoadSoundCALLBACK;
	Module_entry_table[740].fname := 'xLoad3DSound';
	Module_entry_table[740].handler := @xLoad3DSoundCALLBACK;
	Module_entry_table[741].fname := 'xFreeSound';
	Module_entry_table[741].handler := @xFreeSoundCALLBACK;
	Module_entry_table[742].fname := 'xLoopSound';
	Module_entry_table[742].handler := @xLoopSoundCALLBACK;
	Module_entry_table[743].fname := 'xSoundPitch';
	Module_entry_table[743].handler := @xSoundPitchCALLBACK;
	Module_entry_table[744].fname := 'xSoundVolume';
	Module_entry_table[744].handler := @xSoundVolumeCALLBACK;
	Module_entry_table[745].fname := 'xSoundPan';
	Module_entry_table[745].handler := @xSoundPanCALLBACK;
	Module_entry_table[746].fname := 'xPlaySound';
	Module_entry_table[746].handler := @xPlaySoundCALLBACK;
	Module_entry_table[747].fname := 'xStopChannel';
	Module_entry_table[747].handler := @xStopChannelCALLBACK;
	Module_entry_table[748].fname := 'xPauseChannel';
	Module_entry_table[748].handler := @xPauseChannelCALLBACK;
	Module_entry_table[749].fname := 'xResumeChannel';
	Module_entry_table[749].handler := @xResumeChannelCALLBACK;
	Module_entry_table[750].fname := 'xPlayMusic';
	Module_entry_table[750].handler := @xPlayMusicCALLBACK;
	Module_entry_table[751].fname := 'xChannelPitch';
	Module_entry_table[751].handler := @xChannelPitchCALLBACK;
	Module_entry_table[752].fname := 'xChannelVolume';
	Module_entry_table[752].handler := @xChannelVolumeCALLBACK;
	Module_entry_table[753].fname := 'xChannelPan';
	Module_entry_table[753].handler := @xChannelPanCALLBACK;
	Module_entry_table[754].fname := 'xChannelPlaying';
	Module_entry_table[754].handler := @xChannelPlayingCALLBACK;
	Module_entry_table[755].fname := 'xEmitSound';
	Module_entry_table[755].handler := @xEmitSoundCALLBACK;
	Module_entry_table[756].fname := 'xCreateListener';
	Module_entry_table[756].handler := @xCreateListenerCALLBACK;
	Module_entry_table[757].fname := 'xGetListener';
	Module_entry_table[757].handler := @xGetListenerCALLBACK;
	Module_entry_table[758].fname := 'xInitalizeSound';
	Module_entry_table[758].handler := @xInitalizeSoundCALLBACK;
	Module_entry_table[759].fname := 'xCreateSprite';
	Module_entry_table[759].handler := @xCreateSpriteCALLBACK;
	Module_entry_table[760].fname := 'xSpriteViewMode';
	Module_entry_table[760].handler := @xSpriteViewModeCALLBACK;
	Module_entry_table[761].fname := 'xHandleSprite';
	Module_entry_table[761].handler := @xHandleSpriteCALLBACK;
	Module_entry_table[762].fname := 'xLoadSprite';
	Module_entry_table[762].handler := @xLoadSpriteCALLBACK;
	Module_entry_table[763].fname := 'xRotateSprite';
	Module_entry_table[763].handler := @xRotateSpriteCALLBACK;
	Module_entry_table[764].fname := 'xScaleSprite';
	Module_entry_table[764].handler := @xScaleSpriteCALLBACK;
	Module_entry_table[765].fname := 'xCreateSurface';
	Module_entry_table[765].handler := @xCreateSurfaceCALLBACK;
	Module_entry_table[766].fname := 'xGetSurfaceBrush';
	Module_entry_table[766].handler := @xGetSurfaceBrushCALLBACK;
	Module_entry_table[767].fname := 'xAddVertex';
	Module_entry_table[767].handler := @xAddVertexCALLBACK;
	Module_entry_table[768].fname := 'xAddTriangle';
	Module_entry_table[768].handler := @xAddTriangleCALLBACK;
	Module_entry_table[769].fname := 'xSetSurfaceFrustumSphere';
	Module_entry_table[769].handler := @xSetSurfaceFrustumSphereCALLBACK;
	Module_entry_table[770].fname := 'xVertexCoords';
	Module_entry_table[770].handler := @xVertexCoordsCALLBACK;
	Module_entry_table[771].fname := 'xVertexNormal';
	Module_entry_table[771].handler := @xVertexNormalCALLBACK;
	Module_entry_table[772].fname := 'xVertexTangent';
	Module_entry_table[772].handler := @xVertexTangentCALLBACK;
	Module_entry_table[773].fname := 'xVertexBinormal';
	Module_entry_table[773].handler := @xVertexBinormalCALLBACK;
	Module_entry_table[774].fname := 'xVertexColor';
	Module_entry_table[774].handler := @xVertexColorCALLBACK;
	Module_entry_table[775].fname := 'xVertexTexCoords';
	Module_entry_table[775].handler := @xVertexTexCoordsCALLBACK;
	Module_entry_table[776].fname := 'xCountVertices';
	Module_entry_table[776].handler := @xCountVerticesCALLBACK;
	Module_entry_table[777].fname := 'xVertexX';
	Module_entry_table[777].handler := @xVertexXCALLBACK;
	Module_entry_table[778].fname := 'xVertexY';
	Module_entry_table[778].handler := @xVertexYCALLBACK;
	Module_entry_table[779].fname := 'xVertexZ';
	Module_entry_table[779].handler := @xVertexZCALLBACK;
	Module_entry_table[780].fname := 'xVertexNX';
	Module_entry_table[780].handler := @xVertexNXCALLBACK;
	Module_entry_table[781].fname := 'xVertexNY';
	Module_entry_table[781].handler := @xVertexNYCALLBACK;
	Module_entry_table[782].fname := 'xVertexNZ';
	Module_entry_table[782].handler := @xVertexNZCALLBACK;
	Module_entry_table[783].fname := 'xVertexTX';
	Module_entry_table[783].handler := @xVertexTXCALLBACK;
	Module_entry_table[784].fname := 'xVertexTY';
	Module_entry_table[784].handler := @xVertexTYCALLBACK;
	Module_entry_table[785].fname := 'xVertexTZ';
	Module_entry_table[785].handler := @xVertexTZCALLBACK;
	Module_entry_table[786].fname := 'xVertexBX';
	Module_entry_table[786].handler := @xVertexBXCALLBACK;
	Module_entry_table[787].fname := 'xVertexBY';
	Module_entry_table[787].handler := @xVertexBYCALLBACK;
	Module_entry_table[788].fname := 'xVertexBZ';
	Module_entry_table[788].handler := @xVertexBZCALLBACK;
	Module_entry_table[789].fname := 'xVertexU';
	Module_entry_table[789].handler := @xVertexUCALLBACK;
	Module_entry_table[790].fname := 'xVertexV';
	Module_entry_table[790].handler := @xVertexVCALLBACK;
	Module_entry_table[791].fname := 'xVertexW';
	Module_entry_table[791].handler := @xVertexWCALLBACK;
	Module_entry_table[792].fname := 'xVertexRed';
	Module_entry_table[792].handler := @xVertexRedCALLBACK;
	Module_entry_table[793].fname := 'xVertexGreen';
	Module_entry_table[793].handler := @xVertexGreenCALLBACK;
	Module_entry_table[794].fname := 'xVertexBlue';
	Module_entry_table[794].handler := @xVertexBlueCALLBACK;
	Module_entry_table[795].fname := 'xVertexAlpha';
	Module_entry_table[795].handler := @xVertexAlphaCALLBACK;
	Module_entry_table[796].fname := 'xTriangleVertex';
	Module_entry_table[796].handler := @xTriangleVertexCALLBACK;
	Module_entry_table[797].fname := 'xCountTriangles';
	Module_entry_table[797].handler := @xCountTrianglesCALLBACK;
	Module_entry_table[798].fname := 'xPaintSurface';
	Module_entry_table[798].handler := @xPaintSurfaceCALLBACK;
	Module_entry_table[799].fname := 'xClearSurface';
	Module_entry_table[799].handler := @xClearSurfaceCALLBACK;
	Module_entry_table[800].fname := 'xGetSurfaceTexture';
	Module_entry_table[800].handler := @xGetSurfaceTextureCALLBACK;
	Module_entry_table[801].fname := 'xFreeSurface';
	Module_entry_table[801].handler := @xFreeSurfaceCALLBACK;
	Module_entry_table[802].fname := 'xSurfacePrimitiveType';
	Module_entry_table[802].handler := @xSurfacePrimitiveTypeCALLBACK;
	Module_entry_table[803].fname := 'xSurfaceTexture';
	Module_entry_table[803].handler := @xSurfaceTextureCALLBACK;
	Module_entry_table[804].fname := 'xSurfaceColor';
	Module_entry_table[804].handler := @xSurfaceColorCALLBACK;
	Module_entry_table[805].fname := 'xSurfaceAlpha';
	Module_entry_table[805].handler := @xSurfaceAlphaCALLBACK;
	Module_entry_table[806].fname := 'xSurfaceShininess';
	Module_entry_table[806].handler := @xSurfaceShininessCALLBACK;
	Module_entry_table[807].fname := 'xSurfaceBlend';
	Module_entry_table[807].handler := @xSurfaceBlendCALLBACK;
	Module_entry_table[808].fname := 'xSurfaceFX';
	Module_entry_table[808].handler := @xSurfaceFXCALLBACK;
	Module_entry_table[809].fname := 'xSurfaceAlphaRef';
	Module_entry_table[809].handler := @xSurfaceAlphaRefCALLBACK;
	Module_entry_table[810].fname := 'xSurfaceAlphaFunc';
	Module_entry_table[810].handler := @xSurfaceAlphaFuncCALLBACK;
	Module_entry_table[811].fname := 'xCPUName';
	Module_entry_table[811].handler := @xCPUNameCALLBACK;
	Module_entry_table[812].fname := 'xCPUVendor';
	Module_entry_table[812].handler := @xCPUVendorCALLBACK;
	Module_entry_table[813].fname := 'xCPUFamily';
	Module_entry_table[813].handler := @xCPUFamilyCALLBACK;
	Module_entry_table[814].fname := 'xCPUModel';
	Module_entry_table[814].handler := @xCPUModelCALLBACK;
	Module_entry_table[815].fname := 'xCPUStepping';
	Module_entry_table[815].handler := @xCPUSteppingCALLBACK;
	Module_entry_table[816].fname := 'xCPUSpeed';
	Module_entry_table[816].handler := @xCPUSpeedCALLBACK;
	Module_entry_table[817].fname := 'xVideoInfo';
	Module_entry_table[817].handler := @xVideoInfoCALLBACK;
	Module_entry_table[818].fname := 'xVideoAspectRatio';
	Module_entry_table[818].handler := @xVideoAspectRatioCALLBACK;
	Module_entry_table[819].fname := 'xVideoAspectRatioStr';
	Module_entry_table[819].handler := @xVideoAspectRatioStrCALLBACK;
	Module_entry_table[820].fname := 'xGetTotalPhysMem';
	Module_entry_table[820].handler := @xGetTotalPhysMemCALLBACK;
	Module_entry_table[821].fname := 'xGetAvailPhysMem';
	Module_entry_table[821].handler := @xGetAvailPhysMemCALLBACK;
	Module_entry_table[822].fname := 'xGetTotalPageMem';
	Module_entry_table[822].handler := @xGetTotalPageMemCALLBACK;
	Module_entry_table[823].fname := 'xGetAvailPageMem';
	Module_entry_table[823].handler := @xGetAvailPageMemCALLBACK;
	Module_entry_table[824].fname := 'xGetTotalVidMem';
	Module_entry_table[824].handler := @xGetTotalVidMemCALLBACK;
	Module_entry_table[825].fname := 'xGetAvailVidMem';
	Module_entry_table[825].handler := @xGetAvailVidMemCALLBACK;
	Module_entry_table[826].fname := 'xGetTotalVidLocalMem';
	Module_entry_table[826].handler := @xGetTotalVidLocalMemCALLBACK;
	Module_entry_table[827].fname := 'xGetAvailVidLocalMem';
	Module_entry_table[827].handler := @xGetAvailVidLocalMemCALLBACK;
	Module_entry_table[828].fname := 'xGetTotalVidNonlocalMem';
	Module_entry_table[828].handler := @xGetTotalVidNonlocalMemCALLBACK;
	Module_entry_table[829].fname := 'xGetAvailVidNonlocalMem';
	Module_entry_table[829].handler := @xGetAvailVidNonlocalMemCALLBACK;
	Module_entry_table[830].fname := 'xLoadTerrain';
	Module_entry_table[830].handler := @xLoadTerrainCALLBACK;
	Module_entry_table[831].fname := 'xCreateTerrain';
	Module_entry_table[831].handler := @xCreateTerrainCALLBACK;
	Module_entry_table[832].fname := 'xTerrainShading';
	Module_entry_table[832].handler := @xTerrainShadingCALLBACK;
	Module_entry_table[833].fname := 'xTerrainHeight';
	Module_entry_table[833].handler := @xTerrainHeightCALLBACK;
	Module_entry_table[834].fname := 'xTerrainSize';
	Module_entry_table[834].handler := @xTerrainSizeCALLBACK;
	Module_entry_table[835].fname := 'xTerrainX';
	Module_entry_table[835].handler := @xTerrainXCALLBACK;
	Module_entry_table[836].fname := 'xTerrainY';
	Module_entry_table[836].handler := @xTerrainYCALLBACK;
	Module_entry_table[837].fname := 'xTerrainZ';
	Module_entry_table[837].handler := @xTerrainZCALLBACK;
	Module_entry_table[838].fname := 'xModifyTerrain';
	Module_entry_table[838].handler := @xModifyTerrainCALLBACK;
	Module_entry_table[839].fname := 'xTerrainDetail';
	Module_entry_table[839].handler := @xTerrainDetailCALLBACK;
	Module_entry_table[840].fname := 'xTerrainSplatting';
	Module_entry_table[840].handler := @xTerrainSplattingCALLBACK;
	Module_entry_table[841].fname := 'xLoadTerrainTexture';
	Module_entry_table[841].handler := @xLoadTerrainTextureCALLBACK;
	Module_entry_table[842].fname := 'xFreeTerrainTexture';
	Module_entry_table[842].handler := @xFreeTerrainTextureCALLBACK;
	Module_entry_table[843].fname := 'xTerrainTextureLightmap';
	Module_entry_table[843].handler := @xTerrainTextureLightmapCALLBACK;
	Module_entry_table[844].fname := 'xTerrainTexture';
	Module_entry_table[844].handler := @xTerrainTextureCALLBACK;
	Module_entry_table[845].fname := 'xTerrainViewZone';
	Module_entry_table[845].handler := @xTerrainViewZoneCALLBACK;
	Module_entry_table[846].fname := 'xTerrainLODs';
	Module_entry_table[846].handler := @xTerrainLODsCALLBACK;
	Module_entry_table[847].fname := 'xTextureWidth';
	Module_entry_table[847].handler := @xTextureWidthCALLBACK;
	Module_entry_table[848].fname := 'xTextureHeight';
	Module_entry_table[848].handler := @xTextureHeightCALLBACK;
	Module_entry_table[849].fname := 'xCreateTexture';
	Module_entry_table[849].handler := @xCreateTextureCALLBACK;
	Module_entry_table[850].fname := 'xFreeTexture';
	Module_entry_table[850].handler := @xFreeTextureCALLBACK;
	Module_entry_table[851].fname := 'xSetTextureFilter';
	Module_entry_table[851].handler := @xSetTextureFilterCALLBACK;
	Module_entry_table[852].fname := 'xTextureBlend';
	Module_entry_table[852].handler := @xTextureBlendCALLBACK;
	Module_entry_table[853].fname := 'xTextureCoords';
	Module_entry_table[853].handler := @xTextureCoordsCALLBACK;
	Module_entry_table[854].fname := 'xTextureFilter';
	Module_entry_table[854].handler := @xTextureFilterCALLBACK;
	Module_entry_table[855].fname := 'xClearTextureFilters';
	Module_entry_table[855].handler := @xClearTextureFiltersCALLBACK;
	Module_entry_table[856].fname := 'xLoadTexture';
	Module_entry_table[856].handler := @xLoadTextureCALLBACK;
	Module_entry_table[857].fname := 'xTextureName';
	Module_entry_table[857].handler := @xTextureNameCALLBACK;
	Module_entry_table[858].fname := 'xPositionTexture';
	Module_entry_table[858].handler := @xPositionTextureCALLBACK;
	Module_entry_table[859].fname := 'xScaleTexture';
	Module_entry_table[859].handler := @xScaleTextureCALLBACK;
	Module_entry_table[860].fname := 'xRotateTexture';
	Module_entry_table[860].handler := @xRotateTextureCALLBACK;
	Module_entry_table[861].fname := 'xLoadAnimTexture';
	Module_entry_table[861].handler := @xLoadAnimTextureCALLBACK;
	Module_entry_table[862].fname := 'xCreateTextureFromData';
	Module_entry_table[862].handler := @xCreateTextureFromDataCALLBACK;
	Module_entry_table[863].fname := 'xGetTextureData';
	Module_entry_table[863].handler := @xGetTextureDataCALLBACK;
	Module_entry_table[864].fname := 'xGetTextureDataPitch';
	Module_entry_table[864].handler := @xGetTextureDataPitchCALLBACK;
	Module_entry_table[865].fname := 'xGetTextureSurface';
	Module_entry_table[865].handler := @xGetTextureSurfaceCALLBACK;
	Module_entry_table[866].fname := 'xGetTextureFrames';
	Module_entry_table[866].handler := @xGetTextureFramesCALLBACK;
	Module_entry_table[867].fname := 'xSetCubeFace';
	Module_entry_table[867].handler := @xSetCubeFaceCALLBACK;
	Module_entry_table[868].fname := 'xSetCubeMode';
	Module_entry_table[868].handler := @xSetCubeModeCALLBACK;
	Module_entry_table[869].fname := 'xVectorPitch';
	Module_entry_table[869].handler := @xVectorPitchCALLBACK;
	Module_entry_table[870].fname := 'xVectorYaw';
	Module_entry_table[870].handler := @xVectorYawCALLBACK;
	Module_entry_table[871].fname := 'xDeltaPitch';
	Module_entry_table[871].handler := @xDeltaPitchCALLBACK;
	Module_entry_table[872].fname := 'xDeltaYaw';
	Module_entry_table[872].handler := @xDeltaYawCALLBACK;
	Module_entry_table[873].fname := 'xTFormedX';
	Module_entry_table[873].handler := @xTFormedXCALLBACK;
	Module_entry_table[874].fname := 'xTFormedY';
	Module_entry_table[874].handler := @xTFormedYCALLBACK;
	Module_entry_table[875].fname := 'xTFormedZ';
	Module_entry_table[875].handler := @xTFormedZCALLBACK;
	Module_entry_table[876].fname := 'xTFormPoint';
	Module_entry_table[876].handler := @xTFormPointCALLBACK;
	Module_entry_table[877].fname := 'xTFormVector';
	Module_entry_table[877].handler := @xTFormVectorCALLBACK;
	Module_entry_table[878].fname := 'xTFormNormal';
	Module_entry_table[878].handler := @xTFormNormalCALLBACK;
	Module_entry_table[879].fname := 'xOpenMovie';
	Module_entry_table[879].handler := @xOpenMovieCALLBACK;
	Module_entry_table[880].fname := 'xCloseMovie';
	Module_entry_table[880].handler := @xCloseMovieCALLBACK;
	Module_entry_table[881].fname := 'xDrawMovie';
	Module_entry_table[881].handler := @xDrawMovieCALLBACK;
	Module_entry_table[882].fname := 'xMovieWidth';
	Module_entry_table[882].handler := @xMovieWidthCALLBACK;
	Module_entry_table[883].fname := 'xMovieHeight';
	Module_entry_table[883].handler := @xMovieHeightCALLBACK;
	Module_entry_table[884].fname := 'xMoviePlaying';
	Module_entry_table[884].handler := @xMoviePlayingCALLBACK;
	Module_entry_table[885].fname := 'xMovieSeek';
	Module_entry_table[885].handler := @xMovieSeekCALLBACK;
	Module_entry_table[886].fname := 'xMovieLength';
	Module_entry_table[886].handler := @xMovieLengthCALLBACK;
	Module_entry_table[887].fname := 'xMovieCurrentTime';
	Module_entry_table[887].handler := @xMovieCurrentTimeCALLBACK;
	Module_entry_table[888].fname := 'xMoviePause';
	Module_entry_table[888].handler := @xMoviePauseCALLBACK;
	Module_entry_table[889].fname := 'xMovieResume';
	Module_entry_table[889].handler := @xMovieResumeCALLBACK;
	Module_entry_table[890].fname := 'xMovieTexture';
	Module_entry_table[890].handler := @xMovieTextureCALLBACK;
	Module_entry_table[891].fname := 'xCreateWorld';
	Module_entry_table[891].handler := @xCreateWorldCALLBACK;
	Module_entry_table[892].fname := 'xSetActiveWorld';
	Module_entry_table[892].handler := @xSetActiveWorldCALLBACK;
	Module_entry_table[893].fname := 'xGetActiveWorld';
	Module_entry_table[893].handler := @xGetActiveWorldCALLBACK;
	Module_entry_table[894].fname := 'xGetDefaultWorld';
	Module_entry_table[894].handler := @xGetDefaultWorldCALLBACK;
	Module_entry_table[895].fname := 'xDeleteWorld';
	Module_entry_table[895].handler := @xDeleteWorldCALLBACK;


	Module_entry_table[895].fname := 'xLoadScript';
	Module_entry_table[895].handler := @xLoadScriptCALLBACK;
	Module_entry_table[896].fname := 'xExecuteScript';
	Module_entry_table[896].handler := @xExecuteScriptCALLBACK;
	Module_entry_table[897].fname := 'xDeleteScript';
	Module_entry_table[897].handler := @xDeleteScriptCALLBACK;
	Module_entry_table[898].fname := 'xSetIntegerVariable';
	Module_entry_table[898].handler := @xSetIntegerVariableCALLBACK;
	Module_entry_table[899].fname := 'xGetIntegerVariable';
	Module_entry_table[899].handler := @xGetIntegerVariableCALLBACK;
	Module_entry_table[900].fname := 'xSetFloatVariable';
	Module_entry_table[900].handler := @xSetFloatVariableCALLBACK;
	Module_entry_table[901].fname := 'xGetFloatVariable';
	Module_entry_table[901].handler := @xGetFloatVariableCALLBACK;
	Module_entry_table[902].fname := 'xSetStringVariable';
	Module_entry_table[902].handler := @xSetStringVariableCALLBACK;
	Module_entry_table[903].fname := 'xGetStringVariable';
	Module_entry_table[903].handler := @xGetStringVariableCALLBACK;
	Module_entry_table[904].fname := 'xRegisterFunction';
	Module_entry_table[904].handler := @xRegisterFunctionCALLBACK;
	Module_entry_table[905].fname := 'xSetIntegerArg';
	Module_entry_table[905].handler := @xSetIntegerArgCALLBACK;
	Module_entry_table[906].fname := 'xSetFloatArg';
	Module_entry_table[906].handler := @xSetFloatArgCALLBACK;
	Module_entry_table[907].fname := 'xSetStringArg';
	Module_entry_table[907].handler := @xSetStringArgCALLBACK;
	Module_entry_table[908].fname := 'xGetIntegerReturn';
	Module_entry_table[908].handler := @xGetIntegerReturnCALLBACK;
	Module_entry_table[909].fname := 'xGetFloatReturn';
	Module_entry_table[909].handler := @xGetFloatReturnCALLBACK;
	Module_entry_table[910].fname := 'xGetStringReturn';
	Module_entry_table[910].handler := @xGetStringReturnCALLBACK;
	Module_entry_table[911].fname := 'xCreateScript';
	Module_entry_table[911].handler := @xCreateScriptCALLBACK;
	Module_entry_table[912].fname := 'xCurveValue';
	Module_entry_table[912].handler := @CurveValueCALLBACK;

	ModuleEntry.functions :=  @module_entry_table[0];
	ModuleEntry._type := MODULE_PERSISTENT;

	moduleEntry.build_id := StrNew(PAnsiChar(ZEND_MODULE_BUILD_ID));

	Result := @ModuleEntry;
end;

exports
  get_module;

end.
