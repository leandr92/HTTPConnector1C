// BSLLS-off
#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region ПрограммныйИнтерфейс

// Возвращает список тестов
//
Function ПолучитьСписокТестов() Export

	Tests = New Array;
	Tests.Add("Тест_РазобратьURLСоЗнакомРавноВЗначенииПараметраЗапроса");
	Tests.Add("Тест_РазобратьURLСПараметромЗапросаБезЗначения");
	Tests.Add("Тест_РазобратьURLСЯвноЗаданнымПортом");
	Tests.Add("Тест_РазобратьURLСПараметрамиЗапросаСНесколькимиЗначениями");
	Tests.Add("Тест_РазобратьURLСParticleом");
	Tests.Add("Тест_РазобратьURLСХостомВФорматеIPv6");
	Tests.Add("Тест_РазобратьПростойURL");
	Tests.Add("Тест_РазобратьURLСЗакодированнымURLВПараметре");
	
	Tests.Add("Тест_HMAC");
	
	If ProxyConnectionTesting Then
		Tests.Add("Тест_СоединениеЧерезProxy");
	EndIf;
	If TestGettingListReleasesIn1CWebsite Then
		Tests.Add("Тест_ПолучениеСпискаРелизовВСайта1С");
	EndIf;
	Tests.Add("Тест_ПараметрыЗаписиJson");
	Tests.Add("Тест_URLБезСхемы");
	Tests.Add("Тест_ПередачаПараметровВСтрокуЗапроса");
	Tests.Add("Тест_ПередачаПараметровВСтрокуЗапросаКомбинированный");
	Tests.Add("Тест_РезультатКакJsonGet");
	Tests.Add("Тест_РезультатКакJsonPost");
	Tests.Add("Тест_РезультатКакДвоичныеДанные");
	Tests.Add("Тест_РезультатКакТекст");
	Tests.Add("Тест_ПередачаПроизвольныхЗаголовков");
	Tests.Add("Тест_ОтправкаДанныхФормы");
	Tests.Add("Тест_ОтправкаJson");
	Tests.Add("Тест_Таймаут");
	Tests.Add("Тест_BasicAuth");
	Tests.Add("Тест_DigestAuth");
#If Not MobileAppServer Then
	Tests.Add("Тест_ОтправитьGZip");
	Tests.Add("Тест_ПолучитьGZip");
	Tests.Add("Тест_УпаковатьGZip");
	Tests.Add("Тест_РаспаковатьGZip");
#EndIf
	Tests.Add("Тест_GetJson");
	Tests.Add("Тест_PostJson");
	Tests.Add("Тест_PostИРедирект");
	Tests.Add("Тест_GetJsonСтруктура");
	Tests.Add("Тест_PutJson");
	Tests.Add("Тест_DeleteJson");
	Tests.Add("Тест_GetУспешныйРедиректОтносительныйАдрес");
	Tests.Add("Тест_GetУспешныйРедиректАбсолютныйАдрес");
	Tests.Add("Тест_GetЗацикленныйРедирект");
	Tests.Add("Тест_GetОтключенныйРедирект");
	Tests.Add("Тест_РедиректСУказаниемURL");
	Tests.Add("Тест_Ошибка404");
	Tests.Add("Тест_РаботаССессиями");
	Tests.Add("Тест_Options");
	Tests.Add("Тест_Head");
	Tests.Add("Тест_Delete");
	Tests.Add("Тест_Patch");
	Tests.Add("Тест_ПроизвольныйМетод");
	Tests.Add("Тест_УстановкаCookies");
	Tests.Add("Тест_ОтправитьCookies");
	Tests.Add("Тест_POST_MultipartFormData_ТолькоФайл");
	Tests.Add("Тест_POST_MultipartFormData_ФайлыИПоляФормы");
	Tests.Add("Тест_ПараметрыЗапросаТолькоКлюч");
	Tests.Add("Тест_ОтправкаXml");
	Tests.Add("Тест_СложныеПараметрыЗапроса");
	Tests.Add("Тест_PostПустойJson");
	If TestAuthenticationAWS4_HMAC_SHA256 Then
		Tests.Add("Тест_АутентификацияAWS4_HMAC_SHA256");
	EndIf;
	
	Tests.Add("Тест_АутентификацияAWS4_HMAC_SHA256_ПустоеТелоПортНеУказан");
	Tests.Add("Тест_АутентификацияAWS4_HMAC_SHA256_ПустоеТелоУказанСтандартныйПорт");
	Tests.Add("Тест_АутентификацияAWS4_HMAC_SHA256_ПустоеТелоУказанНеСтандартныйПорт");
	
	If TestingRepeats Then
		Tests.Add("Тест_ПовторСУчетомЗаголовкаRetryAfterDate");
		Tests.Add("Тест_ПовторСУчетомЗаголовкаRetryAfterDuration");
		Tests.Add("Тест_ПовторПослеОшибки502");
		Tests.Add("Тест_ПовторПослеОшибкиПодключения");
		Tests.Add("Тест_Ping");
	EndIf;
	
	Return Tests;
	
EndFunction

// Запускает прогон тестов
//
Function ВыполнитьТестыНаСервере(Тесты) Export

	For Each СтрокаТаблицы In Тесты Do
		If Not СтрокаТаблицы.Использование Then
			Continue;
		EndIf;
		
		Try
			Execute(СтрокаТаблицы.Тест + "()");
			СтрокаТаблицы.Результат = "OK";
			СтрокаТаблицы.Ошибка = "";
		Except
			СтрокаТаблицы.Результат = "FAIL";
			СтрокаТаблицы.Ошибка = DetailErrorDescription(ErrorInfo());
		EndTry;
	EndDo;
	
	Return Тесты;
	
EndFunction

#EndRegion

#Region СлужебныеПроцедурыИФункции

#Region Тесты

Procedure Тест_РазобратьURLСоЗнакомРавноВЗначенииПараметраЗапроса() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL(
		"https://httpbin.org/anything?jql=worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01&j&i=2");
	
	УтверждениеВерно(СтруктураURL.Scheme, "https");
	УтверждениеВерно(СтруктураURL.Server, "httpbin.org");
	УтверждениеВерно(СтруктураURL.Path, "/anything");
	УтверждениеВерно(СтруктураURL.Port, 0);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams["jql"], "worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01");
	УтверждениеВерно(СтруктураURL.RequestParams["j"], Undefined);
	УтверждениеВерно(СтруктураURL.RequestParams["i"], "2");
	
EndProcedure

Procedure Тест_РазобратьURLСПараметромЗапросаБезЗначения() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL("https://httpbin.org/get?key");
	
	УтверждениеВерно(СтруктураURL.Scheme, "https");
	УтверждениеВерно(СтруктураURL.Server, "httpbin.org");
	УтверждениеВерно(СтруктураURL.Path, "/get");
	УтверждениеВерно(СтруктураURL.Port, 0);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams["key"], Undefined);
	
EndProcedure

Procedure Тест_РазобратьURLСЯвноЗаданнымПортом() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL("https://httpbin.org:443/get?key");
	
	УтверждениеВерно(СтруктураURL.Scheme, "https");
	УтверждениеВерно(СтруктураURL.Server, "httpbin.org");
	УтверждениеВерно(СтруктураURL.Path, "/get");
	УтверждениеВерно(СтруктураURL.Port, 443);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams["key"], Undefined);
	
EndProcedure

Procedure Тест_РазобратьURLСПараметрамиЗапросаСНесколькимиЗначениями() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL("http://httpbin.org/anything?i=v1&j=w1&j=w2&i=v2&i=v3");
	
	УтверждениеВерно(СтруктураURL.Scheme, "http");
	УтверждениеВерно(СтруктураURL.Server, "httpbin.org");
	УтверждениеВерно(СтруктураURL.Path, "/anything");
	УтверждениеВерно(СтруктураURL.Port, 0);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(StrConcat(СтруктураURL.RequestParams["i"], ", "), "v1, v2, v3");
	УтверждениеВерно(StrConcat(СтруктураURL.RequestParams["j"], ", "), "w1, w2");
	
EndProcedure

Procedure Тест_РазобратьURLСParticleом() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL("https://en.wikipedia.org/wiki/1C_Company#Products");
	
	УтверждениеВерно(СтруктураURL.Scheme, "https");
	УтверждениеВерно(СтруктураURL.Server, "en.wikipedia.org");
	УтверждениеВерно(СтруктураURL.Path, "/wiki/1C_Company");
	УтверждениеВерно(СтруктураURL.Port, 0);
	УтверждениеВерно(СтруктураURL.Particle, "Products");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams.Count(), 0);
	
EndProcedure

Procedure Тест_РазобратьURLСХостомВФорматеIPv6() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL("http://[2001:0db8:11a3:09d7:1f34:8a2e:07a0:765d]:8080/test");
	
	УтверждениеВерно(СтруктураURL.Scheme, "http");
	УтверждениеВерно(СтруктураURL.Server, "[2001:0db8:11a3:09d7:1f34:8a2e:07a0:765d]");
	УтверждениеВерно(СтруктураURL.Path, "/test");
	УтверждениеВерно(СтруктураURL.Port, 8080);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams.Count(), 0);
	
EndProcedure

Procedure Тест_РазобратьПростойURL() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL("http://1c.ru");
	
	УтверждениеВерно(СтруктураURL.Scheme, "http");
	УтверждениеВерно(СтруктураURL.Server, "1c.ru");
	УтверждениеВерно(СтруктураURL.Path, "/");
	УтверждениеВерно(СтруктураURL.Port, 0);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams.Count(), 0);
	
EndProcedure

Procedure Тест_РазобратьURLСЗакодированнымURLВПараметре() Export
	
	СтруктураURL = HTTPConnector.DisassembleTheURL(
		"https://www.example.ru?url=http%3A%2F%2Fwww.kuku.ru%2F%3Fs%3D1%26b%3D2&OTHER=1");
	
	УтверждениеВерно(СтруктураURL.Scheme, "https");
	УтверждениеВерно(СтруктураURL.Server, "www.example.ru");
	УтверждениеВерно(СтруктураURL.Path, "/");
	УтверждениеВерно(СтруктураURL.Port, 0);
	УтверждениеВерно(СтруктураURL.Particle, "");
	УтверждениеВерно(СтруктураURL.Authentication.User, "");
	УтверждениеВерно(СтруктураURL.Authentication.Password, "");
	УтверждениеВерно(СтруктураURL.RequestParams.Count(), 2);
	УтверждениеВерно(СтруктураURL.RequestParams["url"], "http://www.kuku.ru/?s=1&b=2");
	УтверждениеВерно(СтруктураURL.RequestParams["OTHER"], "1");
	
EndProcedure

Procedure Тест_HMAC() Export
	
	Ключ = GetBinaryDataFromString("Секретный ключ", TextEncoding.UTF8, False);
	КлючБольше64 = GetBinaryDataFromString(
		"1234567890123456789012345678901234567890123456789012345678901234567890", TextEncoding.UTF8, False);
	
	ПустыеДанные = GetBinaryDataFromString("", TextEncoding.UTF8, False);
	Данные = GetBinaryDataFromString("Какие-то данные", TextEncoding.UTF8, False);
	
	УтверждениеВерно(
		HTTPConnector.HMAC(Ключ, ПустыеДанные, HashFunction.MD5), 
		GetBinaryDataFromHexString("1b1ec4166a11c03b3afefaea442e7709"));
	УтверждениеВерно(
		HTTPConnector.HMAC(КлючБольше64, Данные, HashFunction.MD5), 
		GetBinaryDataFromHexString("ed5b2d6b9f573cd46e8f8d1d1e8b70e3"));
		
	УтверждениеВерно(
		HTTPConnector.HMAC(Ключ, ПустыеДанные, HashFunction.SHA1), 
		GetBinaryDataFromHexString("355aa0587050d711f4ca9af6930c736363a88d34"));
	УтверждениеВерно(
		HTTPConnector.HMAC(КлючБольше64, Данные, HashFunction.SHA1), 
		GetBinaryDataFromHexString("7e8f9d7ebbe81e508a39f410e157fc6e714b3371"));
		
	УтверждениеВерно(
		HTTPConnector.HMAC(Ключ, ПустыеДанные, HashFunction.SHA256),
		GetBinaryDataFromHexString("70907d03476d72b7276897718590a49f6ce56991112fb5a0e9ed41652b2aab6c"));
	УтверждениеВерно(
		HTTPConnector.HMAC(КлючБольше64, Данные, HashFunction.SHA256),
		GetBinaryDataFromHexString("80be8107de7879f028c8bfe97e10b859785530dd19dfc41a4d6962ce4c2fc130"));

EndProcedure

Procedure Тест_СоединениеЧерезПрокси() Export
	
	Proxy= New InternetProxy;
	Proxy.Set("http", ProxyServer, ProxyPort);
	HTTPConnector.GetJson("http://httpbin.org/headers", Undefined, New Structure("Proxy", Proxy));

EndProcedure

Procedure Тест_ПараметрыЗаписиJson() Export
	
	ПараметрыЗаписиJSON = New Structure("NewLines", JSONLineBreak.None);
	Json = New Structure;
	Json.Insert("field", "value");
	Json.Insert("field2", "value2");
	Результат = HTTPConnector.PostJson("http://httpbin.org/anything", Json, New Structure("JSONWritingParams", ПараметрыЗаписиJSON));
	УтверждениеВерно(Результат["data"], "{""field"":""value"",""field2"":""value2""}");
	
EndProcedure

Procedure Тест_URLБезСхемы() Export
	
	Ответ = HTTPConnector.Get("httpbin.org/get");
	HTTPConnector.AsJSON(Ответ);
 	УтверждениеВерно(Ответ.URL, "http://httpbin.org/get");
	
EndProcedure

Procedure Тест_ПередачаПараметровВСтрокуЗапроса() Export
	
	ПараметрыЗапроса = New Structure;
	ПараметрыЗапроса.Insert("name", StrSplit("Иванов,Петров", ","));
	ПараметрыЗапроса.Insert("salary", Format(100000, "NG="));
	ПараметрыЗапроса.Insert("time", "01:47");
	
	Ответ = HTTPConnector.Get("https://httpbin.org/anything/params", ПараметрыЗапроса);	
	Результат = HTTPConnector.AsJSON(Ответ);
	
	УтверждениеВерно(Ответ.URL, "https://httpbin.org/anything/params?name=%D0%98%D0%B2%D0%B0%D0%BD%D0%BE%D0%B2&name=%D0%9F%D0%B5%D1%82%D1%80%D0%BE%D0%B2&salary=100000&time=01%3A47");
	УтверждениеВерно(Результат["url"], "https://httpbin.org/anything/params?name=Иванов&name=Петров&salary=100000&time=01%3A47");
	УтверждениеВерно(Результат["args"]["salary"], "100000");
	УтверждениеВерно(StrConcat(Результат["args"]["name"], ","), "Иванов,Петров");
	УтверждениеВерно(Результат["args"]["time"], "01:47");
	
EndProcedure

Procedure Тест_ПередачаПараметровВСтрокуЗапросаКомбинированный() Export
	
	ПараметрыЗапроса = New Structure;
	ПараметрыЗапроса.Insert("name", StrSplit("Иванов,Петров", ","));
	ПараметрыЗапроса.Insert("salary", Format(100000, "NG="));
	
	Результат = HTTPConnector.GetJson("https://httpbin.org/anything/params?post=Программист", ПараметрыЗапроса);	
	
	УтверждениеВерно(Результат["args"]["salary"], "100000");
	УтверждениеВерно(Результат["args"]["post"], "Программист");
	УтверждениеВерно(StrConcat(Результат["args"]["name"], ","), "Иванов,Петров");
	
EndProcedure

Procedure Тест_РезультатКакJsonGet() Export
	
	Результат = HTTPConnector.GetJson("https://httpbin.org/get");
	УтверждениеВерно(Результат["url"], "https://httpbin.org/get");
	
EndProcedure

Procedure Тест_РезультатКакJsonPost() Export
	
	Результат = HTTPConnector.AsJSON(HTTPConnector.Post("https://httpbin.org/post"));
	УтверждениеВерно(Результат["url"], "https://httpbin.org/post");
	
EndProcedure

Procedure Тест_РезультатКакДвоичныеДанные() Export
	
	Результат = HTTPConnector.AsBinaryData(HTTPConnector.Get("http://httpbin.org/image/png"));
	
	УтверждениеВерно(TypeOf(Результат), Type("BinaryData"));
	УтверждениеВерно(ПосчитатьMD5(Результат), "5cca6069f68fbf739fce37e0963f21e7");
	
EndProcedure

Procedure Тест_РезультатКакТекст() Export
	
	Результат = HTTPConnector.AsText(HTTPConnector.Get("http://httpbin.org/encoding/utf8"));
	УтверждениеВерно(StrFind(Результат, "Зарегистрируйтесь сейчас на Десятую Международную"), 3931);
	
EndProcedure

Procedure Тест_ПередачаПроизвольныхЗаголовков() Export
	
	Headers = New Map;
	Headers.Insert("X-My-Header", "Hello");
	Результат = HTTPConnector.GetJson("http://httpbin.org/headers", Undefined, New Structure("Headers", Headers));
	
	УтверждениеВерно(Результат["headers"]["X-My-Header"], "Hello");
	
EndProcedure

Procedure Тест_ОтправкаДанныхФормы() Export
	
	Данные = New Structure;
	Данные.Insert("comments", "Постучать в дверь");
	Данные.Insert("custemail", "vasya@mail.ru");
	Данные.Insert("custname", "Вася");
	Данные.Insert("custtel", "112");
	Данные.Insert("delivery", "20:20");
	Данные.Insert("size", "medium");
	Данные.Insert("topping", StrSplit("bacon,mushroom", ","));
	
	Ответ = HTTPConnector.Post("http://httpbin.org/post", Данные);
	УтверждениеВерно(Ответ.URL, "http://httpbin.org/post");
	Результат = HTTPConnector.AsJSON(Ответ);
	УтверждениеВерно(Результат["form"]["size"], "medium");
	УтверждениеВерно(Результат["form"]["comments"], "Постучать в дверь");
	УтверждениеВерно(Результат["form"]["custemail"], "vasya@mail.ru");
	УтверждениеВерно(Результат["form"]["delivery"], "20:20");
	УтверждениеВерно(Результат["form"]["custtel"], "112");	
	
EndProcedure

Procedure Тест_ОтправкаJson() Export
	
	Json = New Structure;
	Json.Insert("Сотрудник", "Иванов Иван Петрович");
	Json.Insert("JobTitle", "Разнорабочий");
	
	Результат = HTTPConnector.PostJson("http://httpbin.org/post", Json);
	
	УтверждениеВерно(Результат["json"]["Сотрудник"], "Иванов Иван Петрович");
	УтверждениеВерно(Результат["json"]["JobTitle"], "Разнорабочий");
	
	Результат = HTTPConnector.PutJson("http://httpbin.org/put", Json);
	УтверждениеВерно(Результат["json"]["Сотрудник"], "Иванов Иван Петрович");
	УтверждениеВерно(Результат["json"]["JobTitle"], "Разнорабочий");
	
EndProcedure

Procedure Тест_Таймаут() Export
	
	Try
		HTTPConnector.Get("https://httpbin.org/delay/10", Undefined, New Structure("Timeout", 1));
	Except
		ВерноеИсключение(ErrorInfo(), StrSplit("Превышено время ожидания|Timeout exceeded", ""));
	EndTry;
	
EndProcedure

Procedure Тест_ПолучитьGZip() Export
	
	Результат = HTTPConnector.GetJson("http://httpbin.org/gzip");
	УтверждениеВерно(Результат["gzipped"], True);
	
EndProcedure

Procedure Тест_ОтправитьGZip() Export
	
	Json = New Structure;
	Json.Insert("field", "value");
	Json.Insert("field2", "value2");
	Headers = New Map;
	Headers.Insert("Content-Encoding", "gzip");
	Результат = HTTPConnector.PostJson("http://httpbin.org/anything", Json, New Structure("Headers", Headers));
	
	ТелоЗапроса = GetBinaryDataFromBase64String(StrSplit(Результат["data"], ",")[1]);
	ИсходноеЗначение = HTTPConnector.JsonInObject(HTTPConnector.ReadGZIP(ТелоЗапроса));
	
	УтверждениеВерно(Результат["headers"]["Content-Encoding"], "gzip");
	УтверждениеВерно(ИсходноеЗначение["field"], Json["field"]);
	УтверждениеВерно(ИсходноеЗначение["field2"], Json["field2"]);
	
EndProcedure

Procedure Тест_BasicAuth() Export
	
	Результат = HTTPConnector.GetJson("https://user:pass@httpbin.org/basic-auth/user/pass");
	УтверждениеВерно(Результат["authenticated"], True);
	УтверждениеВерно(Результат["user"], "user");

	Authentication= New Structure("User, Password", "user", "pass");
	Результат = HTTPConnector.GetJson(
		"https://httpbin.org/basic-auth/user/pass",
		Undefined,
		New Structure("Authentication", Authentication));
	УтверждениеВерно(Результат["authenticated"], True);
	УтверждениеВерно(Результат["user"], "user");

	Authentication= New Structure("User, Password, Type", "user", "pass", "Basic");
	Результат = HTTPConnector.GetJson(
		"https://httpbin.org/basic-auth/user/pass",
		Undefined,
		New Structure("Authentication", Authentication));
	УтверждениеВерно(Результат["authenticated"], True);
	УтверждениеВерно(Результат["user"], "user");
	
EndProcedure

Procedure Тест_DigestAuth() Export
	
	Authentication= New Structure("User, Password, Type", "user", "pass", "Digest");
	Результат = HTTPConnector.GetJson(
		"https://httpbin.org/digest-auth/auth/user/pass",
		Undefined,
		New Structure("Authentication", Authentication));
	УтверждениеВерно(Результат["authenticated"], True);
	УтверждениеВерно(Результат["user"], "user");
	
	Authentication= New Structure("User, Password, Type", "guest", "guest", "Digest");
	Результат = HTTPConnector.Get(
		"https://jigsaw.w3.org/HTTP/Digest/",
		Undefined,
		New Structure("Authentication", Authentication));
	УтверждениеВерно(Результат.StatusCode, 200);
	
EndProcedure

Procedure Тест_GetJson() Export
	
	Результат = HTTPConnector.GetJson("https://httpbin.org/get");
	УтверждениеВерно(Результат["url"], "https://httpbin.org/get");
	
EndProcedure

Procedure Тест_GetJsonСтруктура() Export
	
	ПараметрыПреобразованияJSON = New Structure("ReadInMap", False);
	Результат = HTTPConnector.GetJson(
		"http://httpbin.org/json", Undefined, New Structure("JSONConversionParams", ПараметрыПреобразованияJSON));
	УтверждениеВерно(Результат.slideshow.author, "Yours Truly");
	УтверждениеВерно(Результат.slideshow.date, "date of publication");
	УтверждениеВерно(Результат.slideshow.slides.Count(), 2);
	УтверждениеВерно(Результат.slideshow.title, "Sample Slide Show");
	
EndProcedure

Procedure Тест_PostJson() Export
	
	ПараметрыПреобразованияJSON = New Structure;
	ПараметрыПреобразованияJSON.Insert("PropertyNamesWithDateValues", "Date");
	
	Json = New Structure;
	Json.Insert("Date", '20190121002400');
	Json.Insert("Number", 5);
	Json.Insert("Boolean", True);
	Json.Insert("String", "Привет");
		
	Результат = HTTPConnector.PostJson(
		"https://httpbin.org/post", 
		Json, 
		New Structure("JSONConversionParams", ПараметрыПреобразованияJSON));
	УтверждениеВерно(Результат["url"], "https://httpbin.org/post");
	УтверждениеВерно(Результат["json"]["Date"], '20190121002400');
	УтверждениеВерно(Результат["json"]["Number"], 5);
	УтверждениеВерно(Результат["json"]["Boolean"], True);
	УтверждениеВерно(Результат["json"]["String"], "Привет");
	
EndProcedure

Procedure Тест_PostИРедирект() Export
	
	Ответ = HTTPConnector.Get("https://httpbin.org/redirect-to?url=https%3A%2F%2Fya.ru&status_code=301");
	УтверждениеВерно(Ответ.StatusCode, 200);
	
	Ответ = HTTPConnector.Post("https://httpbin.org/redirect-to?url=https%3A%2F%2Fya.ru&status_code=301");
	УтверждениеВерно(Ответ.StatusCode, 403);
	
EndProcedure

Procedure Тест_PutJson() Export
	
	Результат = HTTPConnector.PutJson("https://httpbin.org/put", New Structure("Название", "КоннекторHTTP"));
	УтверждениеВерно(Результат["url"], "https://httpbin.org/put");
	УтверждениеВерно(Результат["json"]["Название"], "КоннекторHTTP");
	
EndProcedure

Procedure Тест_DeleteJson() Export
	
	Результат = HTTPConnector.DeleteJson("https://httpbin.org/delete", New Structure("Название", "КоннекторHTTP"));
	УтверждениеВерно(Результат["url"], "https://httpbin.org/delete");
	УтверждениеВерно(Результат["json"]["Название"], "КоннекторHTTP");
	
EndProcedure

Procedure Тест_GetУспешныйРедиректОтносительныйАдрес() Export
	
	Ответ = HTTPConnector.Get("https://httpbin.org/relative-redirect/6");
	Результат = HTTPConnector.AsJSON(Ответ);
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	УтверждениеВерно(Результат["url"], "https://httpbin.org/get");
	
EndProcedure

Procedure Тест_GetУспешныйРедиректАбсолютныйАдрес() Export
	
	Ответ = HTTPConnector.Get("http://httpbin.org/absolute-redirect/6");
	Результат = HTTPConnector.AsJSON(Ответ);
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	УтверждениеВерно(Результат["url"], "http://httpbin.org/get");
	
EndProcedure

Procedure Тест_GetЗацикленныйРедирект() Export
	
	Try
		HTTPConnector.AsJSON(HTTPConnector.Get("http://httpbin.org/redirect/31"));
	Except
		ВерноеИсключение(ErrorInfo(), "СлишкомМногоПеренаправлений");
	EndTry;
	
EndProcedure

Procedure Тест_GetОтключенныйРедирект() Export
	
	Параметры = New Structure("AllowRedirect", False);
	Ответ = HTTPConnector.Get(
		"http://httpbin.org/redirect-to?url=http%3A%2F%2Fhttpbin.org%2Fget&status_code=307",
		Undefined,
		Параметры);
	
	УтверждениеВерно(Ответ.StatusCode, 307);
	
EndProcedure

Procedure Тест_РедиректСУказаниемURL() Export
	
	ПараметрыЗапроса = New Structure;
	ПараметрыЗапроса.Insert("url", "https://httpbin.org:443/anything");
	ПараметрыЗапроса.Insert("status_code", "307");

	Ответ = HTTPConnector.Get("http://httpbin.org:80/redirect-to", ПараметрыЗапроса);
	HTTPConnector.AsJSON(Ответ);

	УтверждениеВерно(Ответ.StatusCode, 200);
	УтверждениеВерно(Ответ.URL, "https://httpbin.org:443/anything");
	
EndProcedure

Procedure Тест_Ошибка404() Export
	
	Ответ = HTTPConnector.Get("http://httpbin.org/status/404");
	
	УтверждениеВерно(Ответ.StatusCode, 404);
	
EndProcedure

Procedure Тест_РаботаССессиями() Export
	
	Сессия = HTTPConnector.CreateSession();
	
	HTTPConnector.Get("https://httpbin.org/cookies/set/key/value", Undefined, Undefined, Сессия);
	Результат = HTTPConnector.GetJson("https://httpbin.org/cookies", Undefined, Undefined, Сессия);
	
	УтверждениеВерно(Результат["cookies"]["key"], "value"); 
	
EndProcedure

Procedure Тест_ПолучениеСпискаРелизовВСайта1С() Export
	
	Сессия = HTTPConnector.CreateSession();
	Ответ = HTTPConnector.Get("https://releases.1c.ru/total", Undefined, Undefined, Сессия);
	
	Данные = New Structure;
	Данные.Insert("execution", ИзвлечьExecution(Ответ));
	Данные.Insert("username", Login);
	Данные.Insert("password", Password);
	Данные.Insert("_eventId", "submit");
	Данные.Insert("geolocation", "");
	Данные.Insert("submit", "Войти");
	Данные.Insert("rememberMe", "on");
	
	Ответ = HTTPConnector.Post(Ответ.URL, Данные, Undefined, Сессия);
	
	УтверждениеВерно(Ответ.URL, "https://releases.1c.ru/total");
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_Options() Export
	
	Ответ = HTTPConnector.Options("http://httpbin.org/anything");
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_Head() Export
	
	Ответ = HTTPConnector.Head("http://httpbin.org/anything");
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_Delete() Export
	
	Ответ = HTTPConnector.Delete("http://httpbin.org/delete");
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_Patch() Export
	
	Ответ = HTTPConnector.Patch("http://httpbin.org/patch");
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_ПроизвольныйМетод() Export
	
	Ответ = HTTPConnector.CallMethod("PATCH", "http://httpbin.org/patch");
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_УстановкаCookies() Export
	
	Результат = HTTPConnector.GetJson(
		"http://httpbin.org/cookies/set?PHPSESSID=72a68cc1e55&cookie1=1&cookie2=2&other=test");
	
	УтверждениеВерно(Результат["cookies"]["PHPSESSID"], "72a68cc1e55");
	УтверждениеВерно(Результат["cookies"]["cookie1"], "1");
	УтверждениеВерно(Результат["cookies"]["cookie2"], "2");
	УтверждениеВерно(Результат["cookies"]["other"], "test");
	
EndProcedure

Procedure Тест_ОтправитьCookies() Export
	
	Cookies = New Array;
	Cookies.Add(New Structure("Description,Value", "k1", String(New UUID)));
	Cookies.Add(New Structure("Description,Value", "k2", String(New UUID)));
	Ответ = HTTPConnector.Get("http://httpbin.org/cookies",, New Structure("Cookies", Cookies));
	Результат = HTTPConnector.AsJSON(Ответ);
	
	УтверждениеВерно(Результат["cookies"]["k1"], Cookies[0].Value);
	УтверждениеВерно(Результат["cookies"]["k2"], Cookies[1].Value);
	
EndProcedure

Procedure Тест_POST_MultipartFormData_ТолькоФайл() Export
	
	Файлы = New Structure;
	Файлы.Insert("Name", "f1");
	Файлы.Insert("FileName", "file1.txt");
	Файлы.Insert("Data", Base64Value("0J/RgNC40LLQtdGCLCDQnNC40YA="));
	Файлы.Insert("Type", "text/plain");
	
	Результат = HTTPConnector.PostJson("https://httpbin.org/post", Undefined, New Structure("Files", Файлы));
	
	УтверждениеВерно(Результат["files"]["f1"], "Привет, Мир");
	
EndProcedure

Procedure Тест_POST_MultipartFormData_ФайлыИПоляФормы() Export
	
	Файлы = New Array;
	Файлы.Add(New Structure("Name,Data,FileName", "f1", Base64Value("ZmlsZTE="), "file1.txt"));
	Файлы.Add(New Structure("Name,Data,FileName", "f2", Base64Value("ZmlsZTI="), "file2.txt"));
	
	Данные = New Structure("field1,field2", "value1", "Значение2");
	
	Результат = HTTPConnector.PostJson("https://httpbin.org/post", Undefined, New Structure("Files,Data", Файлы, Данные));
	
	УтверждениеВерно(Результат["files"]["f1"], "file1");
	УтверждениеВерно(Результат["files"]["f2"], "file2");
	УтверждениеВерно(Результат["form"]["field1"], "value1");
	УтверждениеВерно(Результат["form"]["field2"], "Значение2");
	
EndProcedure

Procedure Тест_ПараметрыЗапросаТолькоКлюч() Export

	Результат = HTTPConnector.GetJson("https://httpbin.org/get?key");
	УтверждениеВерно(Результат["args"]["key"], "");
	
EndProcedure

Procedure Тест_ОтправкаXml() Export
	
	XML = 
	"<?xml version=""1.0"" encoding=""utf-8""?>
	|<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLScheme-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLScheme"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
	|  <soap:Body>
	|    <GetCursOnDate xmlns=""http://web.cbr.ru/"">
	|      <On_date>2019-07-05</On_date>
	|    </GetCursOnDate>
	|  </soap:Body>
	|</soap:Envelope>";
	
	Headers = New Map;
	Headers.Insert("Content-Type", "text/xml; charset=utf-8");
	Headers.Insert("SOAPAction", "http://web.cbr.ru/GetCursOnDate");
	Ответ = HTTPConnector.Post(
		"https://www.cbr.ru/DailyInfoWebServ/DailyInfo.asmx",
		XML, 
		New Structure("Headers", Headers));
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	УтверждениеВерно(Ответ.Headers.Get("Content-Type"), "text/xml; charset=utf-8");
	
EndProcedure

Procedure Тест_СложныеПараметрыЗапроса() Export

	Результат = HTTPConnector.GetJson(
		"https://httpbin.org/anything?jql=worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01&j&i=2");
	УтверждениеВерно(Результат["args"]["jql"], "worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01");
	УтверждениеВерно(Результат["args"]["j"], "");
	УтверждениеВерно(Результат["args"]["i"], "2");
	
EndProcedure

Procedure Тест_PostПустойJson() Export
	
	Json = New Structure;
	Результат = HTTPConnector.PostJson("https://httpbin.org/post", Json);
	УтверждениеВерно(Результат["url"], "https://httpbin.org/post");
	УтверждениеВерно(TypeOf(Результат["json"]), Type("Map"));
	
EndProcedure

Procedure Тест_АутентификацияAWS4_HMAC_SHA256() Export
	
	Authentication= New Structure;
	Authentication.Insert("Type", "AWS4-HMAC-SHA256");
	Authentication.Insert("AccessKeyID", AccessKeyID);
	Authentication.Insert("SecretKey", SecretKey);
	Authentication.Insert("State", Region);
	Authentication.Insert("Service", "sqs");

	URL = StrTemplate("https://sqs.%1.amazonaws.com:443%2", Region, Queue);
	
	ПараметрыЗапроса = New Map;
	ПараметрыЗапроса.Insert("Action", "SendMessage");
	ПараметрыЗапроса.Insert("MessageBody", "This is a test message");
	ПараметрыЗапроса.Insert("MessageAttribute.1.Name", "my_attribute_name_1");
	ПараметрыЗапроса.Insert("MessageAttribute.1.Value.StringValue", "my_attribute_value_1");
	ПараметрыЗапроса.Insert("MessageAttribute.1.Value.DataType", "String");
	ПараметрыЗапроса.Insert("MessageAttribute.2.Name", "my_attribute_name_2");
	ПараметрыЗапроса.Insert("MessageAttribute.2.Value.StringValue", "my_attribute_value_2");
	ПараметрыЗапроса.Insert("MessageAttribute.2.Value.DataType", "String");
	ПараметрыЗапроса.Insert("Expires", "2020-05-05T22%3A52%3A43PST");
	ПараметрыЗапроса.Insert("Version", "2012-11-05");
	
	ДополнительныеПараметры = New Structure;
	ДополнительныеПараметры.Insert("Authentication", Authentication);
	Ответ = HTTPConnector.Get(URL, ПараметрыЗапроса, ДополнительныеПараметры);
	
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_УпаковатьGZip() Export
	
	ИсходныеДанные = GetBinaryDataFromString("Привет, Мир!", TextEncoding.UTF8, False);
	СжатыеДанные = GetBinaryDataFromBase64String("H4sIAAAAAAAA/wEVAOr/0J/RgNC40LLQtdGCLCDQnNC40YAhilS6PhUAAAA=");
	
	УтверждениеВерно(HTTPConnector.WriteGzip(ИсходныеДанные), СжатыеДанные);

EndProcedure

Procedure Тест_РаспаковатьGZip() Export
	
	СжатыеДанные = GetBinaryDataFromBase64String("H4sIAAAAAAAA/wEVAOr/0J/RgNC40LLQtdGCLCDQnNC40YAhilS6PhUAAAA=");
	Данные = HTTPConnector.ReadGZIP(СжатыеДанные);
	
	УтверждениеВерно(GetStringFromBinaryData(Данные, TextEncoding.UTF8), "Привет, Мир!");
	
EndProcedure

Procedure Тест_АутентификацияAWS4_HMAC_SHA256_ПустоеТелоПортНеУказан() Export
	
	URL = "https://sqs.eu-north-1.amazonaws.com/123456789101/test";
	
	Authentication= New Structure;
	Authentication.Insert("Type", "AWS4-HMAC-SHA256");
	Authentication.Insert("AccessKeyID", "ACCESS_KEY");
	Authentication.Insert("SecretKey", "SECRET_KEY");
	Authentication.Insert("State", "eu-north-1");
	Authentication.Insert("Service", "sqs");

	Headers = New Map;
	Headers.Insert("x-amz-date", "20200426T122000Z");
	
	Сессия = HTTPConnector.CreateSession();
	Сессия.Headers = Headers;
	Сессия.Authentication= Authentication;
	
	ПодготовленныйЗапрос = HTTPConnector.PrepareRequest(Сессия, "GET", URL, New Structure);
	
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["x-amz-date"], "20200426T122000Z");
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["x-amz-content-sha256"], "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["Authorization"], "AWS4-HMAC-SHA256 Credential=ACCESS_KEY/20200426/eu-north-1/sqs/aws4_request, SignedHeaders=host;x-amz-content-sha256;x-amz-date, Signature=ad98a02ef5df6b5337128ccdac1e5a279846c0d1c4b409e713a75dae0c9e4cb3");
	
EndProcedure

Procedure Тест_АутентификацияAWS4_HMAC_SHA256_ПустоеТелоУказанСтандартныйПорт() Export
	
	URL = "https://sqs.eu-north-1.amazonaws.com:443/123456789101/test";
	
	Authentication= New Structure;
	Authentication.Insert("Type", "AWS4-HMAC-SHA256");
	Authentication.Insert("AccessKeyID", "ACCESS_KEY");
	Authentication.Insert("SecretKey", "SECRET_KEY");
	Authentication.Insert("State", "eu-north-1");
	Authentication.Insert("Service", "sqs");

	Headers = New Map;
	Headers.Insert("x-amz-date", "20200426T122000Z");
	
	Сессия = HTTPConnector.CreateSession();
	Сессия.Headers = Headers;
	Сессия.Authentication= Authentication;
	
	ПодготовленныйЗапрос = HTTPConnector.PrepareRequest(Сессия, "GET", URL, New Structure);
	
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["x-amz-date"], "20200426T122000Z");
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["x-amz-content-sha256"], "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["Authorization"], "AWS4-HMAC-SHA256 Credential=ACCESS_KEY/20200426/eu-north-1/sqs/aws4_request, SignedHeaders=host;x-amz-content-sha256;x-amz-date, Signature=ad98a02ef5df6b5337128ccdac1e5a279846c0d1c4b409e713a75dae0c9e4cb3");
	
EndProcedure

Procedure Тест_АутентификацияAWS4_HMAC_SHA256_ПустоеТелоУказанНеСтандартныйПорт() Export
	
	URL = "https://sqs.eu-north-1.amazonaws.com:444/123456789101/test";
	
	Authentication= New Structure;
	Authentication.Insert("Type", "AWS4-HMAC-SHA256");
	Authentication.Insert("AccessKeyID", "ACCESS_KEY");
	Authentication.Insert("SecretKey", "SECRET_KEY");
	Authentication.Insert("State", "eu-north-1");
	Authentication.Insert("Service", "sqs");

	Headers = New Map;
	Headers.Insert("x-amz-date", "20200426T122000Z");
	
	Сессия = HTTPConnector.CreateSession();
	Сессия.Headers = Headers;
	Сессия.Authentication= Authentication;
	
	ПодготовленныйЗапрос = HTTPConnector.PrepareRequest(Сессия, "GET", URL, New Structure);
	
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["x-amz-date"], "20200426T122000Z");
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["x-amz-content-sha256"], "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
	УтверждениеВерно(ПодготовленныйЗапрос.Headers["Authorization"], "AWS4-HMAC-SHA256 Credential=ACCESS_KEY/20200426/eu-north-1/sqs/aws4_request, SignedHeaders=host;x-amz-content-sha256;x-amz-date, Signature=96df4fab493e08b8a72965acf7a6d2fd651a883a2766a2b0e4c0cd113dea7d8c");
	
EndProcedure

Procedure Тест_ПовторСУчетомЗаголовкаRetryAfterDuration() Export
	
	RepeatForStateCodes = New Array;
	RepeatForStateCodes.Add(HTTPConnector.HTTPStatusCodes().СервисНедоступен_503);
	
	Headers = New Map;
	Headers.Insert("X-ID", String(New UUID));
	
	ДополнительныеПараметры = New Structure;
	ДополнительныеПараметры.Insert("MaximumNumberOfRepetitions", 5);
	ДополнительныеПараметры.Insert("ExponentialDelayRate", 2);
	
	ДополнительныеПараметры.Insert("Headers", Headers);
		
	URL = "http://127.0.0.1:5000/retry_after_duration";
	Ответ = HTTPConnector.Get(URL, Undefined, ДополнительныеПараметры);
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_ПовторСУчетомЗаголовкаRetryAfterDate() Export
	
	RepeatForStateCodes = New Array;
	RepeatForStateCodes.Add(HTTPConnector.HTTPStatusCodes().СервисНедоступен_503);
	
	Headers = New Map;
	Headers.Insert("X-ID", String(New UUID));
	
	ДополнительныеПараметры = New Structure;
	ДополнительныеПараметры.Insert("MaximumNumberOfRepetitions", 5);
	ДополнительныеПараметры.Insert("ExponentialDelayRate", 2);
	
	ДополнительныеПараметры.Insert("Headers", Headers);
		
	URL = "http://127.0.0.1:5000/retry_after_date";
	Ответ = HTTPConnector.Get(URL, Undefined, ДополнительныеПараметры);
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_ПовторПослеОшибки502() Export

	RepeatForStateCodes = New Array;
	RepeatForStateCodes.Add(HTTPConnector.HTTPStatusCodes().BadGateway_502);
	
	Headers = New Map;
	Headers.Insert("X-ID", String(New UUID));
	
	ДополнительныеПараметры = New Structure;
	ДополнительныеПараметры.Insert("MaximumNumberOfRepetitions", 5);
	ДополнительныеПараметры.Insert("RepeatForStateCodes", RepeatForStateCodes);
	
	ДополнительныеПараметры.Insert("Headers", Headers);
		
	URL = "http://127.0.0.1:5000/retry_502";
	Ответ = HTTPConnector.Get(URL, Undefined, ДополнительныеПараметры);
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

Procedure Тест_ПовторПослеОшибкиПодключения() Export

	RepeatForStateCodes = New Array;
	RepeatForStateCodes.Add(HTTPConnector.HTTPStatusCodes().ОшибочныйШлюз_502);
	
	Headers = New Map;
	Headers.Insert("X-ID", String(New UUID));
	
	ДополнительныеПараметры = New Structure;
	ДополнительныеПараметры.Insert("Timeout", 1);
	ДополнительныеПараметры.Insert("MaximumNumberOfRepetitions", 2);
	ДополнительныеПараметры.Insert("RepeatForStateCodes", RepeatForStateCodes);
	
	ДополнительныеПараметры.Insert("Headers", Headers);
	
	Начало = CurrentUniversalDateInMilliseconds();
	URL = "http://127.0.0.1:5001/non_existent_resource";
	Try
		HTTPConnector.Get(URL, Undefined, ДополнительныеПараметры);
	Except
		Длительность = CurrentUniversalDateInMilliseconds() - Начало;
	EndTry;
	УтверждениеВерно(Длительность >= 3000 And Длительность < 7000, True);
	
EndProcedure

Procedure Тест_Ping() Export

	URL = "http://127.0.0.1:5000/ping";
	Ответ = HTTPConnector.Get(URL);
	УтверждениеВерно(Ответ.StatusCode, 200);
	
EndProcedure

#EndRegion

Function ИзвлечьExecution(Ответ)
	
	HTML = HTTPConnector.AsText(Ответ);
	
	Начало = StrFind(HTML, "name=""execution""");
	Конец = StrFind(HTML, ">", SearchDirection.FromBegin, Начало);
	КороткаяСтрока = Mid(HTML, Начало, Конец - Начало);
	
	Начало = StrFind(КороткаяСтрока, "value=""") + StrLen("value=""");
	Конец = StrFind(КороткаяСтрока, """", SearchDirection.FromBegin, Начало); 
	
	Return Mid(КороткаяСтрока, Начало, Конец - Начало);
	
EndFunction

Function ПосчитатьMD5(Данные)
	
	Хеширование = New DataHashing(HashFunction.MD5);
	Хеширование.Append(Данные);
	
	Return Lower(GetHexStringFromBinaryData(Хеширование.HashSum));
	
EndFunction

Procedure УтверждениеВерно(ЛевоеЗначение, ПравоеЗначение, Пояснение = "")
	
	If ЛевоеЗначение <> ПравоеЗначение Then
		Raise(StrTemplate("<%1> не равно <%2>: %3", ЛевоеЗначение, ПравоеЗначение, Пояснение));
	EndIf;
	
EndProcedure

Procedure ВерноеИсключение(ИнформацияОбОшибке, ОжидаемоеИсключение)
	
	ТекстИсключения = DetailErrorDescription(ИнформацияОбОшибке);
	If TypeOf(ОжидаемоеИсключение) = Type("Array") Then
		ТекстНайден = False;
		For Each Элемент In ОжидаемоеИсключение Do
			If StrFind(ТекстИсключения, Элемент) Then
				ТекстНайден = True;
				Break;
			EndIf;
		EndDo;
		
		If Not ТекстНайден Then
			Raise(ТекстИсключения);
		EndIf;
	Else
		If Not StrFind(ТекстИсключения, ОжидаемоеИсключение) Then
			Raise(ТекстИсключения);
		EndIf;
	EndIf;
	
EndProcedure

#EndRegion

#EndIf
