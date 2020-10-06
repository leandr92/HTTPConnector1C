#Region ОбработчикиСобытийФормы

&AtServer
Procedure ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ЗаполнитьСписокТестов();

EndProcedure

&AtServer
Procedure ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)

	ЗаполнитьСписокТестов();

EndProcedure

#EndRegion

#Region ОбработчикиСобытийЭлементовШапкиФормы

&AtClient
Procedure ТестироватьСоединениеЧерезПроксиПриИзменении(Элемент)
	ТестироватьСоединениеЧерезПроксиПриИзмененииНаСервере();
EndProcedure

&AtClient
Procedure ТестироватьПолучениеСпискаРелизовВСайта1СПриИзменении(Элемент)
	ТестироватьПолучениеСпискаРелизовВСайта1СПриИзмененииНаСервере();
EndProcedure

&AtClient
Procedure ТестироватьАутентификациюAWS4_HMAC_SHA256ПриИзменении(Элемент)
	ТестироватьАутентификациюAWS4_HMAC_SHA256ПриИзмененииНаСервере();
EndProcedure

&AtClient
Procedure ТестироватьПовторыПриИзменении(Элемент)
	ТестироватьПовторыПриИзмененииНаСервере();
EndProcedure

#EndRegion

#Region ОбработчикиКомандФормы

&AtClient
Procedure ВыполнитьТесты(Команда)
	
	ВыполнитьТестыНаСервере();
	
EndProcedure

&AtClient
Procedure УстановитьФлажки(Команда)
	
	For Each СтрокаТаблицы In Tests Do
		СтрокаТаблицы.Использование = True;
	EndDo;
	
EndProcedure

&AtClient
Procedure СнятьФлажки(Команда)
	
	For Each СтрокаТаблицы In Tests Do
		СтрокаТаблицы.Использование = False;
	EndDo;
	
EndProcedure

#EndRegion

#Region СлужебныеПроцедурыИФункции

&AtServer
Procedure ЗаполнитьСписокТестов()
	
	Tests.Clear();
	For Each Тест In FormAttributeToValue("Объект").ПолучитьСписокТестов() Do
		НоваяСтрока = Tests.Add();
		НоваяСтрока.Использование = True;
		НоваяСтрока.Тест = Тест;
	EndDo;
	TestsCount = Tests.Count();

EndProcedure

&AtServer
Procedure ТестироватьСоединениеЧерезПроксиПриИзмененииНаСервере()
	
	ЗаполнитьСписокТестов();
	
EndProcedure

&AtServer
Procedure ТестироватьПолучениеСпискаРелизовВСайта1СПриИзмененииНаСервере()

	ЗаполнитьСписокТестов();

EndProcedure

&AtServer
Procedure ТестироватьАутентификациюAWS4_HMAC_SHA256ПриИзмененииНаСервере()

	ЗаполнитьСписокТестов();

EndProcedure

&AtServer
Procedure ТестироватьПовторыПриИзмененииНаСервере()

	ЗаполнитьСписокТестов();

EndProcedure

&AtServer
Procedure ВыполнитьТестыНаСервере()
	
	If CheckFilling() Then
		РезультатаВыполнения = FormAttributeToValue("Объект").ВыполнитьТестыНаСервере(FormAttributeToValue("Tests"));
		ValueToFormAttribute(РезультатаВыполнения, "Tests");
	EndIf;
	
EndProcedure

#EndRegion
