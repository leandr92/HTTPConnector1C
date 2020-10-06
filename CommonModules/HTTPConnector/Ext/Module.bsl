// Connector: comfortable HTTP-client for 1C:Enterprise 8
//
// Copyright 2017-2020 Vladimir Bondarevskiy
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
//
// URL:    https://github.com/vbondarevsky/Connector
// e-mail: vbondarevsky@gmail.com
// Версия: 2.1.3
//
// Requirements: 1С: Enterprise version 8.3.10 and gross

#Region Interface

#Region HTTPMethods

#Region Public

// Send GET request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   RequestParams - Structure, Map - parameters, to be sent URL (part after ?).
//                                                See description Session.RequestParams.
//   AdditionParameters - Structure - See descriptiom param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Get(URL, RequestParams = Undefined, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, RequestParams, Undefined, Undefined);
	Return CallHTTPMethod(CurrentSession, "GET", URL, AdditionParameters);
	
EndFunction

// Send OPTIONS request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Options(URL, AdditionParameters = Undefined, Session = Undefined) Export
	
	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Undefined, Undefined);
	Return CallHTTPMethod(CurrentSession, "OPTIONS", URL, AdditionParameters);
	
EndFunction

// Send HEAD request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   AdditionParameters - Structure - See descriptiom param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Head(URL, AdditionParameters = Undefined, Session = Undefined) Export
	
	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Undefined, Undefined);
	Return CallHTTPMethod(CurrentSession, "HEAD", URL, AdditionParameters);
	
EndFunction

// Send POST request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Data - Structure, Map, String, BinaryData - See description AdditionParameters.Data.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Post(URL, Data = Undefined, AdditionParameters = Undefined, Session = Undefined) Export
	
	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Data, Undefined);
	Return CallHTTPMethod(CurrentSession, "POST", URL, AdditionParameters);

EndFunction

// Send PUT request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Data - Structure, Map, String, BinaryData - See description AdditionParameters.Data.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Put(URL, Data = Undefined, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Data, Undefined);
	Return CallHTTPMethod(CurrentSession, "PUT", URL, AdditionParameters);
	
EndFunction

// Send PATCH request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Data - Structure, Map, String, BinaryData - See description AdditionParameters.Data.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Patch(URL, Data = Undefined, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Data, Undefined);
	Return CallHTTPMethod(CurrentSession, "PATCH", URL, AdditionParameters);
	
EndFunction

// Send DELETE request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Data - Structure, Map, String, BinaryData - See description AdditionParameters.Data.
//   AdditionParameters - Structure - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Structure - Response for request. See description for return value in CallHTTPMethod.
//
Function Delete(URL, Data = Undefined, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Data, Undefined);
	Return CallHTTPMethod(CurrentSession, "DELETE", URL, AdditionParameters);
	
EndFunction

#EndRegion

#Region SimplifiedMetodsForWorkingWithJSONQueries

// Send GET request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   RequestParams - Structure, Map - parameters, to be sent URL (part after ?).
//                                                See description Session.RequestParams.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Map, Structure - response, deserialized JSON. 
//                             Conversion params. See AdditionParameters.JSONConversionParams.
//
Function GetJson(URL, RequestParams = Undefined, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, RequestParams, Undefined, Undefined);
	JSONConversionParams = 
		SelectValue(Undefined, AdditionParameters, "JSONConversionParams", Undefined);
	Return AsJSON(CallHTTPMethod(CurrentSession, "GET", URL, AdditionParameters), JSONConversionParams);
	
EndFunction

// Send POST request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Json - Structure, Map - data to be serialized to JSON.
//   AdditionParameters - Structure - See description param in CallHTTPMethod
//   Session - Structure - See return value of function CreateSession.
//
// Returns:
//   Map, Structure - response, deserialized JSON. 
//                             Conversion params. See AdditionParameters.JSONConversionParams 
//
Function PostJson(URL, Json, AdditionParameters = Undefined, Session = Undefined) Export
	
	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Undefined, Json);
	JSONConversionParams = 
		SelectValue(Undefined, AdditionParameters, "JSONConversionParams", Undefined);
	Return AsJSON(CallHTTPMethod(CurrentSession, "POST", URL, AdditionParameters), JSONConversionParams);

EndFunction

// Send PUT request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Json - Structure, Map - data to be serialized to JSON.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession..
//
// Returns:
//   Map, Structure - Response deserialized from JSON. 
//                            Conversion params. See AdditionParameters.JSONConversionParams 
//
Function PutJson(URL, Json, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Undefined, Json);
	JSONConversionParams = 
		SelectValue(Undefined, AdditionParameters, "JSONConversionParams", Undefined);
	Return AsJSON(CallHTTPMethod(CurrentSession, "PUT", URL, AdditionParameters), JSONConversionParams);
	
EndFunction

// Send DELETE request
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//   Json - Structure, Map - data to be serialized to JSON.
//   AdditionParameters - Structure - See description param in CallHTTPMethod.
//   Session - Structure - See return value of function CreateSession..
//
// Returns:
//   Map, Structure - Response deserialized from JSON. 
//                            Conversion params. See AdditionParameters.JSONConversionParams 
// 
Function DeleteJson(URL, Json, AdditionParameters = Undefined, Session = Undefined) Export

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Undefined, Json);
	JSONConversionParams = 
		SelectValue(Undefined, AdditionParameters, "JSONConversionParams", Undefined);
	Return AsJSON(CallHTTPMethod(CurrentSession, "DELETE", URL, AdditionParameters), JSONConversionParams);
	
EndFunction

#EndRegion

// Sends data to the specified address for processing using the specified HTTP method.
//
// Parameters:
//   Method - String -  the name of the HTTP method for the request.
//   URL - String - resourse URL for request to be sent.
//   AdditionParameters - Structure - allows you to set additional parameters:
//      *Headers - Map - See описание Session.Headers.
//      *Authentication- Structure - See description Session.Authentication
//      *Proxy- InternetProxy - See description Session..
//      *RequestParams - Structure, Map - See description Session.RequestParams.
//      *CheckSSL - Boolean - See description Session.CheckSSL.
//      *SSLСlientСertificate - See description Session.SSLСlientСertificate.
//      *Cookies - Array - See description Session.Cookies.
//      *Timeout - Number - Waiting time for the ongoing connection and operations, in seconds.
// 							Default value is 30 sec.
//      *AllowRedirect - Boolean - True - redirects will be automatically allowed.
//                                           False - only one request to the server will be made.
//      *Json - Structure, Map - data to be serialized to JSON.
//      *JSONConversionParams - Structure - sets the JSON conversion parameters:
//          **ReadInMap - Boolean - If True, the JSON object will be read in Map.
//												If False, Objects Will Be Read in an Object Like Structure.
//          **JSONDateFormat - JSONDateFormat - The format in which the date is presented in a row,
//												to be transformed. 
//          **PropertyNamesWithDateValues -  Array, String - JSON property names,
//														for whom you need to call the date recovery from the line.
//      *JSONWriterSettings - Structure - options used to record an object JSON.
//                                         See in syntax-assistant description JSONWriterSettings.
//      *Data - Structure, Map - Forms fields that need to be sent to the query:
//          **<Key> - String - Field name.
//          **<Value> - String - field value.
//              - String, BinaryData - arbitrary data that needs to be sent in a query.
//      *Files - Structure, Array - files to be sent in request:
//          **Name - String - Form field name.
//          **Data - BinaryData - binary file data.
//          **FileName - String - file name.
//          **Type - String - MIME-type of the file.
//          **Headers - Map, Undefined - HTTP query headers.
//      *MaximumNumberOfRepetitions - Number - number of repeated attempts to connect/submit a request.
//                                        There is a delay between attempts, growing exponentially.
//                                        But if the state code is one of 413, 429, 503
//                                        and the answer is the headline Retry-After,
//                                        the time of the delay is formed from the value of this headline
//                                        Default: 0 - no replays.
//      *MaximumReplayTime - Number - maximum total time (in seconds) to submit a query based on repetitions.
//											Default: 600
//      *ExponentialDelayRate - Number - exponential latency factor.
//                                             1 forms a sequence of delays: 1, 2, 4, 8, etc.
//                                             2 Formed sequence of delays: 2, 4, 8, 16, etc.
//                                             ...
//                                             Default: 1.
//      *RepeatForStateCodes - Undefined - replays will be performed for the states codes of 500.
//                                  - Array - replays will be performed for specific state codes.
//                                    Default: Uncertain.
//   Session - Structure - See return value of function CreateSession..
//
// Returns:
//   Structure - Responding to a request you made:
//      *RunningTime - Number - Time to execute request in milliseconds.
//      *Cookies - Map - cookies received from the server.
//      *Headers - Map - HTTP answer headlines.
//      *ConstantRedirect - Boolean - sign of constant rediect.
//      *isRedirect. - Boolean - sign of redirect.
//      *Encoding - String - coding the text of the answer.
//      *Body - BinaryData - body response.
//      *StateCode - Number - Response status code.
//      *URL - String - the final URL where the query was made.
//
Function CallMethod(Method, URL, AdditionParameters = Undefined, Session = Undefined) Export 

	CurrentSession = ?(Session = Undefined, CreateSession(), Session);
	FillAdditionalParams(AdditionParameters, Undefined, Undefined, Undefined);
	Return CallHTTPMethod(CurrentSession, Method, URL, AdditionParameters);
	
EndFunction

// Creates an object to store session settings.
//
// Returns:
//   Structure - Session options:
//      *Headers - Map - HTTP query headlines.
//      *Authentication- Structure - Request authentication options.
//          *UseOSAuthentication - Boolean - includes the use of NTLM or Negotiate authentication.
//                                                   Default: False.
//          *Type - String - type of authentication. Basic Type may not be specified.
//       	If Type = Digest or Basic: 
//          *User - String - username.
//          *Password - String - user password.
//       If Type = AWS4-HMAC-SHA256:
//          *AccessKeyID - String - Access key ID.
//          *TheSecretKey - String - secret key.
//          *Service - String - The service to which you connect.
//          *Region - String - Region to which you connect.
//      *Proxy- InternetProxy - Proxy options that will be used when you submit a request.
//                Default: Undefined. At the same time, if the configuration uses SSL, 
//                                                     The value of Proxy will be taken from the SSL.
//      *RequestOptions - Structure, Map - options to be sent to the URL (part after ?):
//          *<Key> - String - Option key in URL.
//          *<Value> - String - URL value
//                      - Array - will form a line of several parameters: key'value1'key'value2, etc.
//      *CheckSSl - Boolean - False - Server certificate is not verified.
//                             - True - used vaule OSCertificationAuthorityCertificates. 
//                    - FileCertificationAuthorityCertificates - See in syntax-assistant description
//                                                             FileCertificationAuthorityCertificates.
//                      Default: True.
//      *SSLClientCertificate - FileClientCertificate - See in syntax-assistant description (FileClientCertificate.
//                               - WindowsClientCertificate - See in syntax-assistant description
//                                                            WindowsClientCertificate.
//                                 Default: Undefined.
//      *RedirectMaxCount - Number - maximum number of redirects. Protection from looping.
//                                               Default:
//                                               See function MaximumNumberOfRedirects 
//      *Cookies - Map - хранилище cookies.
//
Function CreateSession() Export
	
	Session = New Structure;
	Session.Insert("Headers", DefaultHeaders());
	Session.Insert("Authentication", Undefined);
	Session.Insert("Proxy", Undefined);
	Session.Insert("RequestParams", New Structure);
	Session.Insert("CheckSSL", True);
	Session.Insert("SSLСlientСertificate", Undefined);
	Session.Insert("RedirectMaxCount", MaximumNumberOfRedirects());
	Session.Insert("Cookies", New Map);
	Session.Insert("ServiceData", New Structure("DigestParams"));
	
	Return Session;
	
EndFunction

#EndRegion

#Region ResponseFormats

// Returns the server response as a deserialized JSON value.
//
// Parameters:
//   Response - Structure - Server response to the sent request. 
//                      	See description param in CallHTTPMethod.
//   JSONConversionParams - Structure - sets the JSON conversion parameters.
//      *ReadInMap - Boolean - If True, reading the JSON object will be performed in Map.
//                                         If False, Objects Will Be Read in an Object Like Structure.
//      *JSONDateFormat - JSONDateFormat - format that shows the date in the line to be converted. 
//      *PropertyNamesWithDateValues -  Array, String - JSON property names,
//                                       Array who need to call the date recovery from the line.
// 
// Returns:
//   Map - server response in the form of jSON de-deeralized value.
//                  If The JSONConversionParams.ReadInMap = True (default).
//   Structure - If JSONConversionParams.ReadInMap = False. 
//
Function AsJSON(Response, JSONConversionParams = Undefined) Export
	
	Return JsonInObject(ExtractResponse(Response), Response.Encoding, JSONConversionParams);
	
EndFunction

// Returns the server's response in the form of text.
//
// Parameters:
//   Response - Structure - Server response to submitted query. 
//                       See CallMethod return description.
//   Encoding - String, TextEncoding - determines the encoding of the text.
//                                         If the value is not set, the encoding is used from the Response.Encoding.
// 
// Returns:
//   String - Server response in the form of text. 
//
Function AsText(Response, Encoding = Undefined) Export
	
	If Not ValueIsFilled(Encoding) Then
		Encoding = Response.Encoding;
	EndIf;
	
	TextReader = New TextReader(ExtractResponse(Response).OpenStreamForRead(), Encoding);
	Text = TextReader.Read();
	TextReader.Close();
	
	If Text = Undefined Then
		Text = "";
	EndIf;
	
	Return Text;
	
EndFunction

// Returns server response to binary data.
//
// Parameters:
//   Response - Structure - Server response to sended request. 
//                       See a description of the value you're returning CallMethod.
//
// Returns:
//   String - server response in the form of binary data. 
//
Function AsBinaryData(Response) Export
	
	Return ExtractResponse(Response);
	
EndFunction

#EndRegion

#Region AuxiliaryFeatures

// Returns a structured URL view.
//
// Parameters:
//   URL - String - resourse URL for request to be sent.
//
// Returns:
//   Structure - структура URL:
//      *Scheme - String - scheme of access to the server (http, https).
//      *Authentication- Structure - Authentication options:
//          *User - String - username.
//          *Password - String - user password.
//      *Server - String - Server address.
//      *Port - Number - server port.
//      *Path - String - resource address on server.
//      *RequestOptions - Map - request settings transferred to the server in the URL (part after ?):
//          *<Key> - String - pption key in URL.
//          *<Value> - String - URL parameter value;
//                      - Array - Parameter values (key=value1&key=value2).
//      *Fragment - String - part of the URL after #. 
//
Function DisassembleTheURL(Val URL) Export

	Scheme = "";
	Path = "";
	Authentication= New Structure("User, Password", "", "");
	Server = "";
	Port = "";
	Fragment = "";
	
	AcceptableSchemes = StrSplit("http,https", ",");
	
	URLWithoutScheme = URL;
	SplitStringByDelimiter(Scheme, URLWithoutScheme, "://");
	If AcceptableSchemes.Find(Lower(Scheme)) <> Undefined Then
		URL = URLWithoutScheme;
	Else
		Scheme = "";
	EndIf;
	
	Result = SplitStringByFirstFindedDelimiter(URL, StrSplit("/,?,#", ","));
	URL = Result[0];
	If ValueIsFilled(Result[2]) Then
		Path = Result[2] + Result[1];
	EndIf;
	
	AuthenticationString = "";
	SplitStringByDelimiter(AuthenticationString, URL, "@");
	If ValueIsFilled(AuthenticationString) Then
		AuthenticationParts = StrSplit(AuthenticationString, ":");
		Authentication.User = AuthenticationParts[0];
		Authentication.Password       = AuthenticationParts[1];
	EndIf;

	// IPv6
	SplitStringByDelimiter(Server, URL, "]");
	If ValueIsFilled(Server) Then
		Server = Server + "]";
	EndIf;
	
	URL = StrReplace(URL, "/", "");
	
	SplitStringByDelimiter(Port, URL, ":", True);
	
	If Not ValueIsFilled(Server) Then
		Server = URL;
	EndIf;
	
	If ValueIsFilled(Port) Then 
		Port = Number(Port);
	Else
		Port = 0;
	EndIf;
	
	SplitStringByDelimiter(Fragment, Path, "#", True);
	
	RequestParams = FillRequestParams(Path);
	
	If Not ValueIsFilled(Scheme) Then
		Scheme = "http";
	EndIf;
	Path = ?(ValueIsFilled(Path), Path, "/");
	
	Result = New Structure;
	Result.Insert("Scheme", Scheme);
	Result.Insert("Authentication", Authentication);
	Result.Insert("Server", Server);
	Result.Insert("Port", Port);
	Result.Insert("Path", Path);
	Result.Insert("RequestParams", RequestParams);
	Result.Insert("Particle", Fragment);

	Return Result;
	
EndFunction

// Conversion the Object into JSON.
//
// Parameters:
//   Object - Arbitrary - data that needs to be converted to JSON.
//   ConversionOptions - Structure - JSON text encoding. Default - utf-8.
//      *JSONDateFormat - JSONDateFormat - defines the format of serialization of JSON-object dates.
//   WriteOptions - Structure - JSON Conversion Options:
//      *LineBreak - JSONLineBreak - determines how lines are moved,
//                      that will be used when recording JSON data.
//      *Indentations - String - identifies the indentations used in JSON data recording.
//      *UseDoubleQuotes - Boolean - determines whether the JSON property names will be recorded
//                                    recorded in double quotes.
//      *CharacterShielding - JSONCharactersEscapeMode - identifies the way you're shielding (replacements)
//                               characters when recording data JSON.
//      *ShieldingCornerBrackets - Boolean - determines whether the characters will be screened when you record "<" и ">".
//      *ShieldingLineSeparators - Boolean - determines whether line dividers will be screened
//                                      U+2028 (line-separator) и U+2029 (page-separator).
//      *ShieldingAmpersand - Boolean - determines whether the ampersand symbol will be shielded when recording "&".
//      *ShieldingSingleQuotes - Boolean - determines whether single quotes will be shielded.
//      *ShieldingSlash - Boolean - determines whether the slash (slash) will be shielded when recording the value.
// 
// Returns:
//   String - Object in format JSON. 
//
Function ObjectToJSON(Object, Val ConversionOptions = Undefined, Val WriteOptions = Undefined) Export
	
	JSONConversionParams = AddToJSONConversionParams(ConversionOptions);
	
	SerializationSettings = New JSONSerializerSettings;
	SerializationSettings.DateSerializationFormat = JSONConversionParams.JSONDateFormat;
	
	WriteOptions = AddJSONWritingParams(WriteOptions);
	
	JSONWritingParams = New JSONWriterSettings(
		WriteOptions.NewLines,
		WriteOptions.PaddingSymbols,
		WriteOptions.UseDoubleQuotes,
		WriteOptions.EscapeCharacters,
		WriteOptions.EscapeAngleBrackets,
		WriteOptions.EscapeLineTerminators,
		WriteOptions.EscapeAmpersand,
		WriteOptions.EscapeSingleQuotes,
		WriteOptions.EscapeSlash);
	
	JSONWriter = New JSONWriter;
	JSONWriter.SetString(JSONWritingParams);
	WriteJSON(JSONWriter, Object, SerializationSettings);
	
	Return JSONWriter.Close();
	
EndFunction

// Conversion JSON into Object.
//
// Parameters:
//   Json - Stream, BinaryData, String - JSON data.
//   Encoding - String - Encoding text of JSON. Default - utf-8.
//   ConversionOptions - Structure - JSON Conversion Options:
//      *ReadInMap - Boolean - If True, the JSON object will be read in Map,
//                                         else in Structure.
//      *PropertyNamesWithDateValues - Array, String, FixedArray - JSON property names,
//                                      for whom you need to call the date recovery from the line.
//      *JSONDateFormat - JSONDateFormat - defines the format of the de-deerization of JSON-object dates.
// 
// Returns:
//   Arbitrary - value, deserialized from JSON. 
//
Function JsonInObject(Json, Encoding = "utf-8", ConversionOptions = Undefined) Export
	
	JSONConversionParams = AddToJSONConversionParams(ConversionOptions);
	
	JSONReader = New JSONReader;
	If TypeOf(Json) = Type("BinaryData") Then
		JSONReader.OpenStream(Json.OpenStreamForRead(), Encoding);
	ElsIf TypeOf(Json) = Type("String") Then
		JSONReader.SetString(Json);
	Else
		JSONReader.OpenStream(Json, Encoding);
	EndIf;
	Object = ReadJSON(
		JSONReader, 
		JSONConversionParams.ReadInMap,
		JSONConversionParams.PropertyNamesWithDateValues,
		JSONConversionParams.JSONDateFormat);
	JSONReader.Close();
	
	Return Object;

EndFunction

// Вычисляет HMAC (hash-based message authentication code).
//
// Parameters:
//   Ключ - BinaryData - секретный ключ.
//   Данные - BinaryData - данные, для которых нужно посчитать HMAC.
//   Алгоритм - HashFunction - алгоритм, используемый для вычисления хеша.
//
// Returns:
//   BinaryData - вычисленное значение HMAC. 
//
Function HMAC(Ключ, Данные, Алгоритм) Export
	
	ДлинаБлока = 64;
	
	If Ключ.Size() > ДлинаБлока Then
		Хеширование = New DataHashing(Алгоритм);
		Хеширование.Append(Ключ);
		
		КлючБуфер = GetBinaryDataBufferFromBinaryData(Хеширование.HashSum);
	Else
		КлючБуфер = GetBinaryDataBufferFromBinaryData(Ключ);
	EndIf;
	
	ИзмененныйКлюч = New BinaryDataBuffer(ДлинаБлока);
	ИзмененныйКлюч.Write(0, КлючБуфер);
	
	ВнутреннийКлюч = ИзмененныйКлюч.Copy();
	ВнешнийКлюч = ИзмененныйКлюч;
	
	ВнутреннееВыравнивание = New BinaryDataBuffer(ДлинаБлока);
	ВнешнееВыравнивание = New BinaryDataBuffer(ДлинаБлока);
	For Индекс = 0 To ДлинаБлока - 1 Do
		ВнутреннееВыравнивание.Set(Индекс, 54);
		ВнешнееВыравнивание.Set(Индекс, 92);
	EndDo;
	
	ВнутреннееХеширование = New DataHashing(Алгоритм);
	ВнешнееХеширование = New DataHashing(Алгоритм);
	
	ВнутреннийКлюч.WriteBitwiseXor(0, ВнутреннееВыравнивание);
	ВнешнийКлюч.WriteBitwiseXor(0, ВнешнееВыравнивание);
	
	ВнешнееХеширование.Append(GetBinaryDataFromBinaryDataBuffer(ВнешнийКлюч));
	ВнутреннееХеширование.Append(GetBinaryDataFromBinaryDataBuffer(ВнутреннийКлюч));
	
	If ValueIsFilled(Данные) Then
		ВнутреннееХеширование.Append(Данные);
	EndIf;
	
	ВнешнееХеширование.Append(ВнутреннееХеширование.HashSum);
	
	Return ВнешнееХеширование.HashSum;

EndFunction

// Returns a structure of named HTTP status codes.
//
// Returns:
//   Structure - named HTTP status codes.
//
Function HTTPStatusCodes() Export

	StatusCodes = New Structure;
	StatusCodes.Insert("OK_200", 200);
	StatusCodes.Insert("Accepted_202", 202);
	StatusCodes.Insert("MovedPermanently_301", 301);
	StatusCodes.Insert("MovedTemporarily_302", 302);
	StatusCodes.Insert("SeeOther_303", 303);
	StatusCodes.Insert("TemporaryRedirect_307", 307);
	StatusCodes.Insert("PermanentRedirect_308", 308);
	StatusCodes.Insert("BadRequest_400", 400);
	StatusCodes.Insert("Unauthorized", 401);
	StatusCodes.Insert("PaymentRequired_402", 402);
	StatusCodes.Insert("Forbidden_403", 403);
	StatusCodes.Insert("PayloadTooLarge_413", 413);
	StatusCodes.Insert("TooManyRequests_429", 429);
	StatusCodes.Insert("InternalServerError_500", 500);
	StatusCodes.Insert("BadGateway_502", 502);
	StatusCodes.Insert("ServiceUnavailable_503", 503);
	StatusCodes.Insert("GatewayTimeout_504", 504);
	
	Return StatusCodes;

EndFunction

// Reads data from the archive GZip.
//
// Parameters:
//   CondensedData - BinaryData - data packaged GZip.
//
// Returns:
//   BinaryData - unpacked data. 
//
Function ReadGZIP(CondensedData) Export
	
	SizeGZipPrefix = 10;
	SizePostfixGZip = 8;
	
	DataReader = New DataReader(CondensedData);
	DataReader.Skip(SizeGZipPrefix);
	SizeOfCompressedData = DataReader.SourceStream().Size() - SizeGZipPrefix - SizePostfixGZip; 
	
	ZipStream = New MemoryStream(ZipSizeLFH() + SizeOfCompressedData + ZipSizeDD() + ZipSizeCDH() + ZipSizeEOCD());
	DataWriter = New DataWriter(ZipStream);
	DataWriter.WriteBinaryDataBuffer(ZipLFH());
	DataReader.CopyTo(DataWriter, SizeOfCompressedData);
	
	DataWriter.Close();
	DataWriter = New DataWriter(ZipStream);
	
	CRC32 = DataReader.ReadInt32();
	SizeOfUncompressedData = DataReader.ReadInt32();
	DataReader.Close();
	
	DataWriter.WriteBinaryDataBuffer(ZipDD(CRC32, SizeOfCompressedData, SizeOfUncompressedData));
	DataWriter.WriteBinaryDataBuffer(ZipCDH(CRC32, SizeOfCompressedData, SizeOfUncompressedData));
	DataWriter.WriteBinaryDataBuffer(ZipEOCD(SizeOfCompressedData));
	DataWriter.Close();
		
	Return ReadZip(ZipStream);
	
EndFunction

// Records the data in the archives of the Gzip..
//
// Parameters:
//   Data - BinaryData - Original Data.
//
// Returns:
//   BinaryData - Data packed GZip.
//
Function WriteGzip(Data) Export

	DataReader = New DataReader(WriteZip(Data));

	InitialOffset = 14;
	DataReader.Skip(InitialOffset);
	CRC32 = DataReader.ReadInt32();

	SizeOfCompressedData = DataReader.ReadInt32();
	SizeOfTheOriginalData = DataReader.ReadInt32();
	
	FileNameSize = DataReader.ReadInt16();
	SizeOfTheExtraField = DataReader.ReadInt16();
	DataReader.Skip(FileNameSize + SizeOfTheExtraField);

	GZipStream = New MemoryStream;
	DataWriter = New DataWriter(GZipStream);
	DataWriter.WriteBinaryDataBuffer(GZipHeader());
	DataReader.CopyTo(DataWriter, SizeOfCompressedData);
	DataWriter.Close();
	DataWriter = New DataWriter(GZipStream);

	DataWriter.WriteBinaryDataBuffer(GZipFooter(CRC32, SizeOfTheOriginalData));

	Return GZipStream.CloseAndGetBinaryData();

EndFunction

#EndRegion

#EndRegion

#Region PrivateProgrammInterface

Function PrepareRequest(Session, Method, URL, AdditionalParams) Export
	
	Cookies = SelectValue(Undefined, AdditionalParams, "Cookies", New Array);
	Cookies = CombineCookies(CompleteCookie(Session.Cookies, URL), CompleteCookie(Cookies, URL));
	
	AuthenticationFromAdditionalParams =
		SelectValue(Undefined, AdditionalParams, "Authentication", New Structure);
	RequestParamsFromAdditionalParams =
		SelectValue(Undefined, AdditionalParams, "RequestParams", New Structure);
	HeadersFromAdditionalParams =
		SelectValue(Undefined, AdditionalParams, "Headers", New Map);

	Authentication= CombineAuthenticationOptions(AuthenticationFromAdditionalParams, Session.Authentication);
	RequestParams = CombineRequestSettings(RequestParamsFromAdditionalParams, Session.RequestParams);
	Headers = CombineHeaders(HeadersFromAdditionalParams, Session.Headers);
	JSONConversionParams = 
		SelectValue(Undefined, AdditionalParams, "JSONConversionParams", Undefined);
		
	PreparedRequest = New Structure;
	PreparedRequest.Insert("Cookies", Cookies);
	PreparedRequest.Insert("Authentication", Authentication);
	PreparedRequest.Insert("Method", Method);
	PreparedRequest.Insert("Headers", Headers);
	PreparedRequest.Insert("RequestParams", RequestParams);
	PreparedRequest.Insert("URL", PrepareURL(URL, RequestParams));
	PreparedRequest.Insert("JSONConversionParams", JSONConversionParams);
	
	PrepareCookies(PreparedRequest);

	Data = SelectValue(Undefined, AdditionalParams, "Data", New Structure);
	Files = SelectValue(Undefined, AdditionalParams, "Files", New Array);
	Json = SelectValue(Undefined, AdditionalParams, "Json", Undefined);
	JSONWritingParams = SelectValue(Undefined, AdditionalParams, "JSONWritingParams", Undefined);

	PrepareRequestBody(PreparedRequest, Data, Files, Json, JSONWritingParams);
	PrepareAuthentication(PreparedRequest);

	Return PreparedRequest;
	
EndFunction

#EndRegion

#Region ServiceProceduresAndFunctions

Function IsStatusCodeThereforeHeaderRetryAfter(StatusCode)

	Codes = HTTPStatusCodes();
	Return StatusCode = Codes.PayloadTooLarge_413
		Or StatusCode = Codes.TooManyRequests_429
		Or StatusCode = Codes.ServiceUnavailable_503;

EndFunction

Function NumberFromString(Val String) Export

	TypeDescription = New TypeDescription("Number");
	Return TypeDescription.AdjustValue(String);

EndFunction

Function ДатаИзСтроки(Val Строка) Export

	КвалификаторДаты = New DateQualifiers(DateFractions.DateTime);
	ОписаниеТипа = New TypeDescription("Date", Undefined, Undefined, КвалификаторДаты);
	Return ОписаниеТипа.AdjustValue(Строка);

EndFunction

Function ДатаИзСтрокиRFC7231(Val Строка) Export
	
	Разделители = ",-:/\.";
	For Индекс = 1 To StrLen(Разделители) Do
		Разделитель = Mid(Разделители, Индекс, 1);
		Строка = StrReplace(Строка, Разделитель, " ");
	EndDo;
	Строка = StrReplace(Строка, "  ", " ");
	СоставляющиеДаты = StrSplit(Строка, " ");
	МесяцСтр = СоставляющиеДаты[2];

	Месяцы = StrSplit("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec", ",");
	Месяц = Месяцы.Find(МесяцСтр);
	If Месяц = Undefined Then
		Return '00010101';
	EndIf;
	
	Дата = СоставляющиеДаты[3] + Format(Месяц + 1, "ND=2; NLZ=;") + СоставляющиеДаты[1];
	Время = СоставляющиеДаты[4] + СоставляющиеДаты[5] + СоставляющиеДаты[6];

	Return ДатаИзСтроки(Дата + Время);
 
EndFunction

Function CallHTTPMethod(Session, Method, URL, AdditionParams)
	
	HTTPStatusCodes = HTTPStatusCodes();
	
	PreparedRequest = PrepareRequest(Session, Method, URL, AdditionParams);
	
	ConnectionSettings = GetConnectionSettings(Method, URL, AdditionParams);
	
	Response = SendRequest(Session, PreparedRequest, ConnectionSettings);
	
	Redirect = 0;
	While Redirect < Session.RedirectMaxCount Do
		If Not ConnectionSettings.AllowRedirect Or Not Response.IsRedirect Then
			Return Response;
		EndIf;
		
		NewURL = СформироватьНовыйURLПриПеренаправлении(Response);

		PreparedRequest.URL = EncodeString(NewURL, StringEncodingMethod.URLInURLEncoding);
		NewHTTPRequest = New HTTPRequest(CollectResourceAddress(DisassembleTheURL(NewURL), Undefined));
		OverrideMethod(PreparedRequest, Response);
			
		If Response.StatusCode <> HTTPStatusCodes.TemporaryRedirect_307
			And Response.StatusCode <> HTTPStatusCodes.PermanentRedirect_308 Then
			УдалитьЗаголовки(PreparedRequest.Headers, "content-length,content-type,transfer-encoding");
			NewHTTPRequest.Headers = PreparedRequest.Headers;
		Else
			OriginalStream = PreparedRequest.HTTPRequest.GetBodyAsStream();
			OriginalStream.CopyTo(NewHTTPRequest.GetBodyAsStream());
		EndIf;
		PreparedRequest.HTTPRequest = NewHTTPRequest;
		УдалитьЗаголовки(PreparedRequest.Headers, "cookies");

		PreparedRequest.Cookies = CombineCookies(Session.Cookies, PreparedRequest.Cookies);
		PrepareCookies(PreparedRequest);
		
		// INFO: good authentication needs to lead to new parameters, but for now we will ignore.
		
		Response = SendRequest(Session, PreparedRequest, ConnectionSettings);
		
		Redirect = Redirect + 1;
	EndDo;
	
	Raise("TooManyRedirects");
	
EndFunction

Function СформироватьНовыйURLПриПеренаправлении(Ответ)

	НовыйURL = GetHeaderValue("location", Ответ.Headers);
	НовыйURL = DecodeString(НовыйURL, StringEncodingMethod.URLInURLEncoding);
	
	// Редирект без схемы
	If StrStartsWith(НовыйURL, "//") Then
		СтруктураURL = DisassembleTheURL(Ответ.URL);
		НовыйURL = СтруктураURL.Схема + ":" + НовыйURL;
	EndIf;

	СтруктураURL = DisassembleTheURL(НовыйURL);
	If Not ValueIsFilled(СтруктураURL.Server) Then
		СтруктураURLОтвета = DisassembleTheURL(Ответ.URL);
		БазовыйURL = StrTemplate("%1://%2", СтруктураURLОтвета.Scheme, СтруктураURLОтвета.Server);
		If ValueIsFilled(СтруктураURLОтвета.Port) Then
			БазовыйURL = БазовыйURL + Format(СтруктураURLОтвета.Port, "NGS=; NG=");
		EndIf;
		НовыйURL = БазовыйURL + НовыйURL;
	EndIf;

	Return НовыйURL;

EndFunction

Procedure УдалитьЗаголовки(Headers, СписокЗаголовковСтрокой)

	ЗаголовкиДляУдаления = New Array;
	СписокЗаголовков = StrSplit(СписокЗаголовковСтрокой, ",", False);
	For Each Заголовок In Headers Do
		If СписокЗаголовков.Find(Lower(Заголовок.Key)) <> Undefined Then
			ЗаголовкиДляУдаления.Add(Заголовок.Key);
		EndIf;
	EndDo;
	For Each ЗаголовокДляУдаления In ЗаголовкиДляУдаления Do
		Headers.Delete(ЗаголовокДляУдаления);
	EndDo;

EndProcedure

Function GetConnectionSettings(Method, URL, AdditionalParams) 

	AllowRedirect = 
		GetValueByKey(AdditionalParams, "AllowRedirect", Upper(Method) <> "HEAD");
	CheckSSL = GetValueByKey(AdditionalParams, "CheckSSL", True);
	SSLСlientСertificate = GetValueByKey(AdditionalParams, "SSLСlientСertificate");
	Proxy= GetValueByKey(AdditionalParams, "Proxy", GetDefaultProxy(URL));
	MaximumNumberOfRepetitions = GetValueByKey(AdditionalParams, "MaximumNumberOfRepetitions", 0);
	RepeatForStateCodes = 
		GetValueByKey(AdditionalParams, "RepeatForStateCodes", Undefined);
	ExponentialDelayRate = 
		GetValueByKey(AdditionalParams, "ExponentialDelayRate", 1);
	MaximumReplayTime = GetValueByKey(AdditionalParams, "MaximumReplayTime", 600);

	Settings = New Structure;
	Settings.Insert("Timeout", GetTimeout(AdditionalParams));
	Settings.Insert("AllowRedirect", AllowRedirect);
	Settings.Insert("CheckSSL", CheckSSL);
	Settings.Insert("SSLСlientСertificate", SSLСlientСertificate);
	Settings.Insert("Proxy", Proxy);
	Settings.Insert("MaximumNumberOfRepetitions", MaximumNumberOfRepetitions);
	Settings.Insert("RepeatForStateCodes", RepeatForStateCodes);
	Settings.Insert("ExponentialDelayRate", ExponentialDelayRate);
	Settings.Insert("MaximumReplayTime", MaximumReplayTime);

	Return Settings;

EndFunction

Function GetTimeout(AdditionalParams)
	
	If AdditionalParams.Property("Timeout") And ValueIsFilled(AdditionalParams.Timeout) Then
		Timeout = AdditionalParams.Timeout;
	Else
		Timeout = StandardTimeout();
	EndIf;
	
	Return Timeout;
	
EndFunction

Function GetDefaultProxy(URL)
	
	DefaultProxy = New InternetProxy;
	// BSLLS:ExecuteExternalCodeInCommonModule-off
	CMNameGettingFiles = "GetFilesFromInternetClientServer";
	If Metadata.CommonModules.Find(CMNameGettingFiles) <> Undefined Then
		URLStructure = DisassembleTheURL(URL);
		Module = Eval(CMNameGettingFiles);
		DefaultProxy = Module.GetProxy(URLStructure.Scheme);
	EndIf;
	// BSLLS:ExecuteExternalCodeInCommonModule-on
	
	Return DefaultProxy;
	
EndFunction

Function CompleteCookie(Cookies, URL)
	
	URLStructure = DisassembleTheURL(URL);
	NewCookies = New Array;
	If TypeOf(Cookies) = Type("Array") Then
		For Each Cookie In Cookies Do
			NewCookie = CookieConstructor(Cookie.Description, Cookie.Value);
			FillPropertyValues(NewCookie, Cookie);
			
			If Not ValueIsFilled(NewCookie.Domain) Then
				NewCookie.Domain = URLStructure.Server;
			EndIf;
			If Not ValueIsFilled(NewCookie.Path) Then
				NewCookie.Path = "/";
			EndIf;
			
			NewCookies.Add(NewCookie);
		EndDo;
		
		Return NewCookies;
	EndIf;
	
	Return Cookies;
	
EndFunction

Procedure RemoveCookieFromStorage(CookieStorage, Cookie)

	If CookieStorage.Get(Cookie.Domain) <> Undefined
		And CookieStorage[Cookie.Domain].Get(Cookie.Path) <> Undefined
		And CookieStorage[Cookie.Domain][Cookie.Path].Get(Cookie.Description) <> Undefined Then
		CookieStorage[Cookie.Domain][Cookie.Path].Delete(Cookie.Description);
	EndIf;

EndProcedure

Procedure AddACookieToStorage(CookiesStorage, Cookie, Replace = False)
	
	If CookiesStorage.Get(Cookie.Domain) = Undefined Then
		CookiesStorage[Cookie.Domain] = New Map;
	EndIf;
	If CookiesStorage[Cookie.Domain].Get(Cookie.Path) = Undefined Then
		CookiesStorage[Cookie.Domain][Cookie.Path] = New Map;
	EndIf;
	If CookiesStorage[Cookie.Domain][Cookie.Path].Get(Cookie.Description) = Undefined Or Replace Then
		CookiesStorage[Cookie.Domain][Cookie.Path][Cookie.Description] = Cookie;
	EndIf;
	
EndProcedure

Function AddALeadingPoint(Val Domain)
	
	If Not StrStartsWith(Domain, ".") Then
		Domain = "." + Domain;
	EndIf;
	
	Return Domain;
	
EndFunction

Procedure FillInAListOfFilteredCookies(Cookies, URLStructure, List)

	For Each Cookie In Cookies Do
		If Cookie.Value.HTTPSOnly = True And URLStructure.Scheme <> "https" Then
			Continue;
		EndIf;
		// INFO: expiration check is ignored (Cookie.Value.ExpirationDate)
		// INFO: Port check ignored
		
		List.Add(Cookie.Value);
	EndDo;

EndProcedure

Function SelectCookiesForRequest(URLStructure, Cookies)
	
	ServerInRequest = AddALeadingPoint(URLStructure.Server);
	
	Result = New Array;
	For Each Domain In Cookies Do
		If Not StrEndsWith(ServerInRequest, Domain.Key) Then
			Continue;
		EndIf;
		For Each Path In Domain.Value Do
			If Not StrStartsWith(URLStructure.Path, Path.Key) Then
				Continue;
			EndIf;
			FillInAListOfFilteredCookies(Path.Value, URLStructure, Result);
		EndDo;
	EndDo;
	
	Return Result;
	
EndFunction

Function PrepareACookieHeader(PreparedRequest)
	
	URLStructure = DisassembleTheURL(PreparedRequest.URL);
	
	Cookies = New Array;
	For Each Cookie In SelectCookiesForRequest(URLStructure, PreparedRequest.Cookies) Do
		Cookies.Add(StrTemplate("%1=%2", Cookie.Description, Cookie.Value));
	EndDo;
	
	Return StrConcat(Cookies, "; ");
	
EndFunction

Procedure PrepareCookies(PreparedRequest)
	
	HeaderCookie = PrepareACookieHeader(PreparedRequest);
	If ValueIsFilled(HeaderCookie) Then
		PreparedRequest.Headers["Cookie"] = HeaderCookie;
	EndIf;
	
EndProcedure

Function EncodeRequestParams(RequestParams)
	
	RequestParamsParts = New Array;
	For Each Param In RequestParams Do
		If TypeOf(Param.Value) = Type("Array") Then
			Value = Param.Value;
		Else
			Value = New Array;
			Value.Add(Param.Value);
		EndIf;
		
		If Param.Value = Undefined Then
			RequestParamsParts.Add(Param.Key);
		Else
			For Each Value In Value Do
				ParamValue = EncodeString(Value, StringEncodingMethod.URLEncoding);
				RequestParamsParts.Add(StrTemplate("%1=%2", Param.Key, ParamValue));
			EndDo;
		EndIf;
	EndDo;
	
	Return StrConcat(RequestParamsParts, "&");
	
EndFunction

Function PrepareURL(Val URL, RequestParams = Undefined)
	
	URL = TrimL(URL);
	
	URLStructure = DisassembleTheURL(URL);
	
	PreparedURL = URLStructure.Scheme + "://";
	If ValueIsFilled(URLStructure.Authentication.User) Then
		PreparedURL = PreparedURL 
			+ URLStructure.Authentication.User + ":"
			+ URLStructure.Authentication.Password + "@";
	EndIf;
	PreparedURL = PreparedURL + URLStructure.Server;
	If ValueIsFilled(URLStructure.Port) Then
		PreparedURL = PreparedURL + ":" + Format(URLStructure.Port, "NGS=; NG=");
	EndIf;
	
	PreparedURL = PreparedURL + CollectResourceAddress(URLStructure, RequestParams);
		
	Return PreparedURL;
	
EndFunction

Function HeadersInString(Headers)
	
	StringDelimeter = Chars.CR + Chars.LF;
	Strings = New Array;
	
	SortedHeaders = "Content-Disposition,Content-Type,Content-Location";
	For Each KeyName In StrSplit(SortedHeaders, ",") Do
		Value = GetHeaderValue(KeyName, Headers);
		If Value <> False And ValueIsFilled(Value) Then
			Strings.Add(StrTemplate("%1: %2", KeyName, Value));
		EndIf;
	EndDo;
	
	Keys = StrSplit(Upper(SortedHeaders), ",");
	For Each Header In Headers Do
		If Keys.Find(Upper(Header.Key)) = Undefined Then
			Strings.Add(StrTemplate("%1: %2", Header.Key, Header.Value));
		EndIf;
	EndDo;
	Strings.Add(StringDelimeter);
	
	Return StrConcat(Strings, StringDelimeter);
	
EndFunction

Function GetValueByKey(Structure, Key, DefaultValue = Undefined)
	
	If TypeOf(Structure) = Type("Structure") And Structure.Property(Key) Then
		Value = Structure[Key];
	ElsIf TypeOf(Structure) = Type("Map") And Structure.Get(Key) <> Undefined Then
		Value = Structure.Get(Key);
	Else
		Value = DefaultValue;
	EndIf;
	
	Return Value;
	
EndFunction
	
Function CreateFormField(OriginalParams)
	
	Field = New Structure("Name,FileName,Data,Type,Headers");
	Field.Name = OriginalParams.Name;
	Field.Data = OriginalParams.Data;
	
	Field.Type = GetValueByKey(OriginalParams, "Type");
	Field.Headers = GetValueByKey(OriginalParams, "Headers", New Map);
	Field.FileName = GetValueByKey(OriginalParams, "FileName");
	
	KeyName = "Content-Disposition";
	If GetHeaderValue("content-disposition", Field.Headers, KeyName) = False Then
		Field.Headers.Insert("Content-Disposition", "form-data");
	EndIf;
	
	Parts = New Array;
	Parts.Add(Field.Headers[KeyName]);
	Parts.Add(StrTemplate("name=""%1""", Field.Name));
	If ValueIsFilled(Field.FileName) Then
		Parts.Add(StrTemplate("filename=""%1""", Field.FileName));
	EndIf;
	
	Field.Headers[KeyName] = StrConcat(Parts, "; ");
	Field.Headers["Content-Type"] = Field.Type;
	
	Return Field;
	
EndFunction

Function EncodeFiles(HTTPRequest, Files, Data)
	
	Parts = New Array;
	If ValueIsFilled(Data) Then
		For Each Field In Data Do
			Parts.Add(CreateFormField(New Structure("Name,Data", Field.Key, Field.Value)));
		EndDo;
	EndIf;
	If TypeOf(Files) = Type("Array") Then
		For Each File In Files Do
			Parts.Add(CreateFormField(File));
		EndDo;
	Else
		Parts.Add(CreateFormField(Files));
	EndIf;
	
	Delimeters = StrReplace(New UUID, "-", "");
	StringDelimeter = Chars.CR + Chars.LF;
	
	RequestBody = HTTPRequest.GetBodyAsStream();
	DataWriter = New DataWriter(RequestBody, TextEncoding.UTF8, ByteOrder.LittleEndian, "", "", False);
	For Each Part In Parts Do
		DataWriter.WriteLine("--" + Delimeters + StringDelimeter);
		DataWriter.WriteLine(HeadersInString(Part.Headers));
		If TypeOf(Part.Data) = Type("BinaryData") Then
			DataWriter.Write(Part.Data);
		Else
			DataWriter.WriteLine(Part.Data);
		EndIf;
		DataWriter.WriteLine(StringDelimeter);
	EndDo;
	DataWriter.WriteLine("--" + Delimeters + "--" + StringDelimeter);
	DataWriter.Close();
	
	Return StrTemplate("multipart/form-data; boundary=%1", Delimeters);
	
EndFunction

Procedure PrepareRequestBody(PreparedRequest, Data, Files, Json, JSONWritingParams)
	
	URLStructure = DisassembleTheURL(PreparedRequest.URL);

	HTTPRequest = New HTTPRequest;
	HTTPRequest.ResourceAddress = CollectResourceAddress(URLStructure, PreparedRequest.RequestParams);
	If ValueIsFilled(Files) Then
		ContentType = EncodeFiles(HTTPRequest, Files, Data);
	ElsIf ValueIsFilled(Data) Then
		ContentType = "application/x-www-form-urlencoded";
		If TypeOf(Data) = Type("BinaryData") Then
			HTTPRequest.SetBodyFromBinaryData(Data);
		Else
			If TypeOf(Data) = Type("String") Then
				Body = Data;
			Else
				Body = EncodeRequestParams(Data);
			EndIf;
			HTTPRequest.SetBodyFromString(Body, TextEncoding.UTF8, ByteOrderMarkUse.DontUse);
		EndIf;
	ElsIf Json <> Undefined Then
		ContentType = "application/json";
		JSONString = ObjectToJSON(Json, PreparedRequest.JSONConversionParams, JSONWritingParams);
		HTTPRequest.SetBodyFromString(JSONString, TextEncoding.UTF8, ByteOrderMarkUse.DontUse);
	Else
		ContentType = Undefined;
	EndIf;
	HeaderValue = GetHeaderValue("content-type", PreparedRequest.Headers);
	If HeaderValue = False And ValueIsFilled(ContentType) Then
		PreparedRequest.Headers.Insert("Content-Type", ContentType);
	EndIf;
	
	HTTPRequest.Headers = PreparedRequest.Headers;
	
	WrapRequest(HTTPRequest);

	PreparedRequest.Insert("HTTPRequest", HTTPRequest);
	
EndProcedure

Procedure PrepareAuthentication(RequestPrepared)
	
	RequestPrepared.Insert("EventsToResponse", New Array);
	If Not ValueIsFilled(RequestPrepared.Authentication) Then
		URLStructure = DisassembleTheURL(RequestPrepared.URL);
		If ValueIsFilled(URLStructure.Authentication) Then
			RequestPrepared.Authentication= URLStructure.Authentication;
		EndIf;
	EndIf;
	
	If ValueIsFilled(RequestPrepared.Authentication) Then
		If RequestPrepared.Authentication.Property("Type") Then
			AuthenticationType = Lower(RequestPrepared.Authentication.Type);
			If AuthenticationType = "digest" Then
				RequestPrepared.EventsToResponse.Add("ProcessingResponseWithCode401");
			EndIf;
			If AuthenticationType = "aws4-hmac-sha256" Then
				PrepareAuthenticationOfAWS4(RequestPrepared);
			EndIf;
		EndIf;
	EndIf;
	
EndProcedure

Function CombineCookies(MainSource, AdditionalSource)
	
	Cookies = New Map;
	For Each Cookie In ConvertCookiesIntoAnArrayOfCookies(MainSource) Do
		AddACookieToStorage(Cookies, Cookie, False);
	EndDo;
	For Each Cookie In ConvertCookiesIntoAnArrayOfCookies(AdditionalSource) Do
		AddACookieToStorage(Cookies, Cookie, False);
	EndDo;
	
	Return Cookies;
	
EndFunction

Function ConvertCookiesIntoAnArrayOfCookies(CookiesStorage)
	
	Cookies = New Array;
	If TypeOf(CookiesStorage) = Type("Array") Then
		For Each Cookie In CookiesStorage Do
			NewCookie = CookieConstructor();
			FillPropertyValues(NewCookie, Cookie);
			Cookies.Add(NewCookie);
		EndDo;
		
		Return Cookies;
	EndIf;
	
	For Each Domain In CookiesStorage Do
		For Each Path In Domain.Value Do
			For Each Name In Path.Value Do
				Cookies.Add(Name.Value);
			EndDo;
		EndDo;
	EndDo;
	
	Return Cookies;
	
EndFunction

Function CombineAuthenticationOptions(MainSource, AdditionalSource)
	
	AuthenticationOptions = New Structure;
	If TypeOf(MainSource) = Type("Structure") Then
		For Each Param In MainSource Do
			AuthenticationOptions.Insert(Param.Key, Param.Value);
		EndDo;
	EndIf;
	If TypeOf(AdditionalSource) = Type("Structure") Then
		For Each Param In AdditionalSource Do
			If Not AuthenticationOptions.Property(Param) Then
				AuthenticationOptions.Insert(Param.Key, Param.Value);
			EndIf;
		EndDo;
	EndIf;
	
	Return AuthenticationOptions;
	
EndFunction

Function CombineHeaders(MainSource, AdditionalSource)
	
	Headers = New Map;
	For Each Header In MainSource Do
		Headers.Insert(Header.Key, Header.Value);
	EndDo;
	For Each Header In AdditionalSource Do
		If Headers.Get(Header.Key) = Undefined Then
			Headers.Insert(Header.Key, Header.Value);
		EndIf;
	EndDo;
	
	Return Headers;
	
EndFunction

Function CombineRequestSettings(MainSource, AdditionalSource)
	
	RequestParams = New Map;
	If TypeOf(MainSource) = Type("Structure") Or TypeOf(MainSource) = Type("Map") Then
		For Each Param In MainSource Do
			RequestParams.Insert(Param.Key, Param.Value);
		EndDo;
	EndIf;
	If TypeOf(AdditionalSource) = Type("Structure") Or TypeOf(AdditionalSource) = Type("Map") Then
		For Each Param In AdditionalSource Do
			If RequestParams.Get(Param) = Undefined Then
				RequestParams.Insert(Param.Key, Param.Value);
			EndIf;
		EndDo;
	EndIf;
	
	Return RequestParams;
	
EndFunction

Function SendHTTPRequest(Session, PreparedRequest, Settings)
	
	URLStructure = DisassembleTheURL(PreparedRequest.URL);
	Connection = GetConnection(URLStructure, PreparedRequest.Authentication, Settings, Session);
	Response = Connection.CallHTTPMethod(PreparedRequest.Method, PreparedRequest.HTTPRequest);
	
	For Each Handler In PreparedRequest.EventsToResponse Do
		If Handler = "ProcessingResponseWithCode401" Then
			ProcessingResponseWithCode401(Session, PreparedRequest, Settings, Response);
		EndIf;
	EndDo;
	
	Return Response;
	
EndFunction

Function РассчитатьДлительностьПриостановки(Повтор, ExponentialDelayRate, ЗаголовокRetryAfter, Остаток)

	If ЗаголовокRetryAfter <> False Then
		Длительность = NumberFromString(ЗаголовокRetryAfter);

		If Длительность = 0 Then
			Дата = ДатаИзСтрокиRFC7231(ЗаголовокRetryAfter);
			If ValueIsFilled(Дата) Then
				Длительность = Дата - CurrentUniversalDate();
			EndIf;
		EndIf;
	Else
		Длительность = ExponentialDelayRate * Pow(2, Повтор - 1);
	EndIf;

	Длительность = Min(Длительность, Остаток);

	If Длительность < 0 Then
		Длительность = 0;
	EndIf;

	Return Длительность;

EndFunction

Function НеобходимоПовторитьЗапрос(Ответ, Настройки, ОшибкаВыполненияЗапроса)

	If Настройки.MaximumNumberOfRepetitions < 1 Then
		Return False;
	EndIf;
	
	If ОшибкаВыполненияЗапроса <> Undefined Then
		Return True;
	EndIf;

	ПовторПриЛюбомКодеСостоянияБольшеИлиРавным500 = Настройки.RepeatForStateCodes = Undefined
		And Ответ.StatusCode >= HTTPStatusCodes().ВнутренняяОшибкаСервера_500;
	КодСостоянияСоответствуетКодуСостоянияПовтора = TypeOf(Настройки.RepeatForStateCodes) = Type("Array")
		And Настройки.RepeatForStateCodes.Find(Ответ.StatusCode) <> Undefined;
	If ПовторПриЛюбомКодеСостоянияБольшеИлиРавным500 Or КодСостоянияСоответствуетКодуСостоянияПовтора Then
		Return True;
	EndIf;

	ЗаголовокRetryAfter = GetHeaderValue("retry-after", Ответ.Headers);
	Return ЗаголовокRetryAfter <> False 
		And IsStatusCodeThereforeHeaderRetryAfter(Ответ.StatusCode);

EndFunction

Function SendRequest(Session, PreparedRequest, Settings)
	
	Start = CurrentUniversalDateInMilliseconds();
	MillisecondsPerSecond = 1000;

	Repeat = 0;
	Duration = 0;
	While True Do
		Try
			Response = SendHTTPRequest(Session, PreparedRequest, Settings);
		Except
			RequestFailure = ErrorInfo();
		EndTry;

		Repeat = Repeat + 1;
		Duration = (CurrentUniversalDateInMilliseconds() - Start) / MillisecondsPerSecond;

		If Not НеобходимоПовторитьЗапрос(Response, Settings, RequestFailure) Then
			Break;
		EndIf;

		If Repeat > Settings.MaximumNumberOfRepetitions 
			Or Duration > Settings.MaximumReplayTime Then
			Break;
		EndIf;
	
		If RequestFailure <> Undefined 
			Or Not IsStatusCodeThereforeHeaderRetryAfter(Response.StatusCode) Then
			HeaderRetryAfter = False;
		Else
			HeaderRetryAfter = GetHeaderValue("retry-after", Response.Headers);
		EndIf;
		PauseDuration = РассчитатьДлительностьПриостановки(
			Repeat,
			Settings.ExponentialDelayRate,
			HeaderRetryAfter,
			Settings.MaximumReplayTime - Duration);
		Pause(PauseDuration);
	EndDo;
	
	If RequestFailure <> Undefined Then
		Raise(DetailErrorDescription(RequestFailure));
	EndIf;

	ContentTypeHeader = GetHeaderValue("content-type", Response.Headers);
	If ContentTypeHeader = False Then
		ContentTypeHeader = "";
	EndIf;
	
	PreparedResponse = New Structure;
	PreparedResponse.Insert("RunningTime", CurrentUniversalDateInMilliseconds() - Start);
	PreparedResponse.Insert("Cookies", CheckOutCookies(Response.Headers, PreparedRequest.URL)); 
	PreparedResponse.Insert("Headers", Response.Headers);
	PreparedResponse.Insert("IsPermanentRedirect", IsPermanentRedirect(Response.StatusCode, Response.Headers));
	PreparedResponse.Insert("IsRedirect", IsRedirect(Response.StatusCode, Response.Headers));
	PreparedResponse.Insert("Encoding", GetEncodingFromHeader(ContentTypeHeader));
	PreparedResponse.Insert("Body", Response.GetBodyAsBinaryData());
	PreparedResponse.Insert("StatusCode", Response.StatusCode);
	PreparedResponse.Insert("URL", PreparedRequest.URL);
	
	Session.Cookies = CombineCookies(Session.Cookies, PreparedResponse.Cookies);
	
	Return PreparedResponse;
	
EndFunction

Procedure OverrideMethod(PreparedRequest, Response)
	
	HTTPStatusCodes = HTTPStatusCodes();
	
	Method = PreparedRequest.Method;

	// http://tools.ietf.org/html/rfc7231#section-6.4.4
	If Response.StatusCode = HTTPStatusCodes.SeeOther_303 And Method <> "HEAD" Then
		Method = "GET";
	EndIf;
	
	// Browser behavior
	If Response.StatusCode = HTTPStatusCodes.MovedTemporarily_302 And Method <> "HEAD" Then
		Method = "GET";
	EndIf;
	
	PreparedRequest.Method = Method;
	
EndProcedure	

Function CheckOutCookies(Headers, URL)
	
	CurrentTime = CurrentUniversalDate();
	Cookies = New Map;
	For Each Header In Headers Do
		If Lower(Header.Key) = "set-cookie" Then
			For Each CookieHeader In SplitIntoIndividualCookies(Header.Value) Do
				Cookie = ParseCookie(CookieHeader, URL, CurrentTime);
				If Cookie = Undefined Then
					Continue;
				EndIf;
				If Cookie.ExpirationDate <= CurrentTime Then
					RemoveCookieFromStorage(Cookies, Cookie);
				Else
					AddACookieToStorage(Cookies, Cookie);
				EndIf;
			EndDo;
		EndIf;
	EndDo;
	
	Return Cookies;
	
EndFunction

Function SplitIntoIndividualCookies(Val Header)
	
	Headers = New Array;
	
	If Not ValueIsFilled(Header) Then
		Return Headers;
	EndIf;
	
	HeadersParts = StrSplit(Header, ",", False);
	
	SeparatedHeader = HeadersParts[0];
	For Index = 1 To HeadersParts.UBound() Do
		CommaDot = StrFind(HeadersParts[Index], ";");
		Equals = StrFind(HeadersParts[Index], "=");
		If CommaDot And Equals And Equals < CommaDot Then
			Headers.Add(SeparatedHeader);
			SeparatedHeader = HeadersParts[Index];
		Else
			SeparatedHeader = SeparatedHeader + HeadersParts[Index];
		EndIf;
	EndDo;
	Headers.Add(SeparatedHeader);
	
	Return Headers;
	
EndFunction

Function CookieConstructor(Name = "", Value = Undefined)
	
	NewCookie = New Structure;
	NewCookie.Insert("Description", Name);
	NewCookie.Insert("Value", Value);
	NewCookie.Insert("Domain", "");
	NewCookie.Insert("Path", "");
	NewCookie.Insert("Port");
	NewCookie.Insert("ExpirationDate", '39990101');
	NewCookie.Insert("HTTPSOnly");
	
	Return NewCookie;
	
EndFunction

Function CreateCookieAndFillInBasicsParams(Param)

	Parts = StrSplit(Param, "=", False);
	Name = Parts[0];
	If Parts.Count() > 1 Then
		Value = Parts[1];
	EndIf;

	Return CookieConstructor(Name, Value);

EndFunction

Function ParseCookie(Header, URL, CurrentTime)
	
	Cookie = Undefined;
	Index = 0;
	
	For Each Param In StrSplit(Header, ";", False) Do
		Index = Index + 1;
		Param = TrimAll(Param);
		
		If Index = 1 Then
			Cookie = CreateCookieAndFillInBasicsParams(Param);
			Continue;
		EndIf;
		
		Parts = StrSplit(Param, "=", False);
		KeyName = Lower(Parts[0]);
		If Parts.Count() > 1 Then
			Value = Parts[1];
		EndIf;

		If KeyName = "domain" Then
			Cookie.Domain = Value;
		ElsIf KeyName = "path" Then
			Cookie.Path = Value;
		ElsIf KeyName = "secure" Then
			Cookie.HTTPSOnly = True;
		ElsIf KeyName = "max-age" Then
			СрокДействияMaxAge = CurrentTime + NumberFromString(Value);
		ElsIf KeyName = "expires" Then
			Cookie.ExpirationDate = ДатаИзСтрокиRFC7231(Value);
		Else
			Continue;
		EndIf;
	EndDo;
	If ValueIsFilled(Cookie) And ValueIsFilled(СрокДействияMaxAge) Then
		Cookie.ExpirationDate = СрокДействияMaxAge;
	EndIf;
	
	FillCookieWithImplicitValues(Cookie, URL);

	Return Cookie;
	
EndFunction

Procedure FillCookieWithImplicitValues(Cookie, URL)

	If Cookie = Undefined Then
		Return;
	EndIf;

	URLStructure = DisassembleTheURL(URL);
	If Not ValueIsFilled(Cookie.Domain) Then
		Cookie.Domain = URLStructure.Server;
	EndIf;
	If Not ValueIsFilled(Cookie.Port) And ValueIsFilled(URLStructure.Port) Then
		Cookie.Port = URLStructure.Port;
	EndIf;
	If Not ValueIsFilled(Cookie.Path) Then
		PositionOfTheLastSlash = StrFind(URLStructure.Path, "/", SearchDirection.FromEnd);
		If PositionOfTheLastSlash <= 1 Then
			Cookie.Path = "/";
		Else
			Cookie.Path = Left(URLStructure.Path, PositionOfTheLastSlash - 1);
		EndIf;
	EndIf;

EndProcedure

Function GetHeaderValue(Header, AllHeaders, Key = Undefined)
	
	For Each CurrentHeader In AllHeaders Do
		If Lower(CurrentHeader.Key) = Lower(Header) Then
			Key = CurrentHeader.Key;
			Return CurrentHeader.Value;
		EndIf;
	EndDo;
	
	Return False;
	
EndFunction

Function IsPermanentRedirect(StatusCode, Headers)
	
	HTTPStatusCodes = HTTPStatusCodes();
	
	Return ThereIsHeaderLocation(Headers) And 
		(StatusCode = HTTPStatusCodes.MovedPermanently_301 
		Or StatusCode = HTTPStatusCodes.MovedTemporarily_302);
	
EndFunction

Function IsRedirect(StatusCode, Headers)
	
	HTTPStateCodes = HTTPStatusCodes();
	
	RedirectState = New Array;
	RedirectState.Add(HTTPStateCodes.MovedPermanently_301);
	RedirectState.Add(HTTPStateCodes.MovedTemporarily_302);
	RedirectState.Add(HTTPStateCodes.SeeOther_303);
	RedirectState.Add(HTTPStateCodes.TemporaryRedirect_307);
	RedirectState.Add(HTTPStateCodes.PermanentRedirect_308);
	
	Return ThereIsHeaderLocation(Headers) And RedirectState.Find(StatusCode) <> Undefined;
	
EndFunction

Function ThereIsHeaderLocation(Headers)
	
	Return GetHeaderValue("location", Headers) <> False;
	
EndFunction

Function GetEncodingFromHeader(Val Header)

	Encoding = Undefined;
	
	Header = Lower(TrimAll(Header));
	DividerIndex = StrFind(Header, ";");
	If DividerIndex Then
		ContentType = TrimAll(Left(Header, DividerIndex - 1));
		CodingKey = "charset=";
		CodingIndex = StrFind(Header, CodingKey);
		If CodingIndex Then
			DividerIndex = StrFind(Header, ";", SearchDirection.FromBegin, CodingIndex);
			StartingPosition = CodingIndex + StrLen(CodingKey);
			If DividerIndex Then
				EncodingLength = DividerIndex - StartingPosition;
			Else
				EncodingLength = StrLen(Header);
			EndIf;
			Encoding = Mid(Header, StartingPosition, EncodingLength);
			Encoding = StrReplace(Encoding, """", "");
			Encoding = StrReplace(Encoding, "'", "");
		EndIf;
	Else
		ContentType = Header;
	EndIf;
	
	If Encoding = Undefined And StrFind(ContentType, "text") Then
		Encoding = "iso-8859-1";
	EndIf;
	
	Return Encoding;
	
EndFunction

Function CollectResourceAddress(URLStructure, RequestParams)
	
	URL = URLStructure.Path;
	
	JointRequestParams = CombineRequestSettings(RequestParams, URLStructure.RequestParams);
	If ValueIsFilled(JointRequestParams) Then
		URL = URL + "?" + EncodeRequestParams(JointRequestParams);
	EndIf;
	If ValueIsFilled(URLStructure.Particle) Then
		URL = URL + "#" + URLStructure.Particle;
	EndIf;
	
	Return URL;
	
EndFunction

Function GetSecureConnection(AdditionalParams)
	
	If AdditionalParams.CheckSSL = False Then
		CertificatesAC = Undefined;
	ElsIf TypeOf(AdditionalParams.CheckSSL) = Type("FileCertificationAuthorityCertificates") Then
		CertificatesAC = AdditionalParams.CheckSSL;
	Else
		CertificatesAC = New OSCertificationAuthorityCertificates;
	EndIf;
	ClientCertificate = Undefined;
	If AdditionalParams.SSLСlientСertificate = Type("FileClientCertificate") 
		Or AdditionalParams.SSLСlientСertificate = Type("WindowsClientCertificate") Then
		ClientCertificate = AdditionalParams.SSLСlientСertificate;
	EndIf;
	
	Return New OpenSSLSecureConnection(ClientCertificate, CertificatesAC);
	
EndFunction

Function GetConnection(ConnectionParams, Authentication, AdditionalParams, Session)
	
	If Not ValueIsFilled(ConnectionParams.Port) Then
		If ConnectionParams.Scheme = "https" Then
			ConnectionParams.Port = 443;
		Else
			ConnectionParams.Port = 80;
		EndIf;
	EndIf;
	
	SecureConnection = Undefined;
	If ConnectionParams.Scheme = "https" Then
		SecureConnection = GetSecureConnection(AdditionalParams);
	EndIf;
	
	User = "";
	Password = "";
	If ValueIsFilled(Authentication) Then
		If Authentication.Property("User") And Authentication.Property("Password") Then
			User = Authentication.User;
			Password = Authentication.Password;
		EndIf;
	EndIf;
	
	UseOSAuthentication = Authentication.Property("UseOSAuthentication") 
		And Authentication.UseOSAuthentication = True;
		
	OptionsForCalculatingID = New Array;
	OptionsForCalculatingID.Add(ConnectionParams.Server);
	OptionsForCalculatingID.Add(ConnectionParams.Port);
	OptionsForCalculatingID.Add(User);
	OptionsForCalculatingID.Add(Password);
	OptionsForCalculatingID.Add(AdditionalParams.Timeout);
	OptionsForCalculatingID.Add(UseOSAuthentication);
	OptionsForCalculatingID.Add(SecureConnection);
	OptionsForCalculatingID.Add(AdditionalParams.Proxy);
	
	If Not Session.Property("ServiceData") Or TypeOf(Session.ServiceData) <> Type("Structure") Then
		Session.Insert("ServiceData", New Structure);
	EndIf;
	If Not Session.ServiceData.Property("PoolConnections") Then
		Session.ServiceData.Insert("PoolConnections", New Map);
	EndIf;
	PoolConnections = Session.ServiceData.PoolConnections;
	
	ConnectionID = GetConnectionID(OptionsForCalculatingID);
	
	If PoolConnections.Get(ConnectionID) = Undefined Then
		NewConnection = New HTTPConnection(
			ConnectionParams.Server,
			ConnectionParams.Port,
			User, Password,
			AdditionalParams.Proxy, 
			AdditionalParams.Timeout, 
			SecureConnection,
			UseOSAuthentication);
		PoolConnections.Insert(ConnectionID, NewConnection);
	EndIf;
	
	Return PoolConnections[ConnectionID];
	
EndFunction

Function GetConnectionID(ConnectionParams)
	
	OptionsForCalculatingID = New Array;
	
	For Each Item In ConnectionParams Do
		ItemType = TypeOf(Item);
		If ItemType = Type("InternetProxy") Then
			OptionsForCalculatingID.Add(StrConcat(Item.BypassProxyOnAddresses, ""));
			OptionsForCalculatingID.Add(XMLString(Item.BypassProxyOnLocal));
			OptionsForCalculatingID.Add(Item.User);
			OptionsForCalculatingID.Add(Item.Password);
		ElsIf ItemType = Type("OpenSSLSecureConnection") Then
			// To make it easier, it would be accepted that the certificates in the session do not change
			If Item.ClientCertificate = Undefined Then
				OptionsForCalculatingID.Add("");
			Else
				OptionsForCalculatingID.Add(String(TypeOf(Item.ClientCertificate)));
			EndIf;
			If Item.CertificationAuthorityCertificates = Undefined Then
				OptionsForCalculatingID.Add("");
			Else
				OptionsForCalculatingID.Add(String(TypeOf(Item.CertificationAuthorityCertificates)));
			EndIf;
		Else
			OptionsForCalculatingID.Add(XMLString(Item));
		EndIf;
	EndDo;
	
	Return DataHashing(HashFunction.MD5, StrConcat(OptionsForCalculatingID, ""));
	
EndFunction

Function SelectValue(MainValue, AdditionalValues, Key, DefaultValue)
	
	If MainValue <> Undefined Then
		Return MainValue;
	EndIf;
	
	Value = GetValueByKey(AdditionalValues, Key);
	If Value <> Undefined Then
		Return Value;
	EndIf;
	
	Return DefaultValue;
	
EndFunction

Function FillRequestParams(Path)

	RequestParams = New Map;
	
	Request = "";
	SplitStringByDelimiter(Request, Path, "?", True);
	For Each StringKeyEqualsParam In StrSplit(Request, "&", False) Do
		StringKeyEqualsParam = DecodeString(
			StringKeyEqualsParam, StringEncodingMethod.URLInURLEncoding);

		EqPosition = StrFind(StringKeyEqualsParam, "=");
		If EqPosition = 0 Then
			EqKey = StringKeyEqualsParam;
			EqValue = Undefined;
		Else
			EqKey = Left(StringKeyEqualsParam, EqPosition - 1);
			EqValue = Mid(StringKeyEqualsParam, EqPosition + 1);
		EndIf;

		If RequestParams.Get(EqKey) <> Undefined Then
			If TypeOf(RequestParams[EqKey]) = Type("Array") Then
				RequestParams[EqKey].Add(EqValue);
			Else
				Values = New Array;
				Values.Add(RequestParams[EqKey]);
				Values.Add(EqValue);
				RequestParams[EqKey] = Values;
			EndIf;
		Else
			RequestParams.Insert(EqKey, EqValue);
		EndIf;
		
	EndDo;
	
	Return RequestParams;

EndFunction

Procedure SplitStringByDelimiter(ExtractedPart, OtherPart, Delimiter, Inversion = False)
	
	Index = StrFind(OtherPart, Delimiter);
	If Index Then
		ExtractedPart = Left(OtherPart, Index - 1);
		OtherPart = Mid(OtherPart, Index + StrLen(Delimiter));
		If Inversion Then
			ForExchange = ExtractedPart;
			ExtractedPart = OtherPart;
			OtherPart = ForExchange;
		EndIf;
	EndIf;
	
EndProcedure

Function SplitStringByFirstFindedDelimiter(String, Delimiters)
	
	MinimumIndex = StrLen(String);
	FirstDelimiter = "";
	
	For Each Delimiter In Delimiters Do
		Index = StrFind(String, Delimiter);
		If Index = 0 Then
			Continue;
		EndIf;
		If Index < MinimumIndex Then
			MinimumIndex = Index;
			FirstDelimiter = Delimiter;
		EndIf;
	EndDo;
	
	Result = New Array;
	If ValueIsFilled(FirstDelimiter) Then
		Result.Add(Left(String, MinimumIndex - 1));
		Result.Add(Mid(String, MinimumIndex + StrLen(FirstDelimiter)));
		Result.Add(FirstDelimiter);
	Else
		Result.Add(String);
		Result.Add("");
		Result.Add(Undefined);
	EndIf;
	
	Return Result;
	
EndFunction

Function AddToJSONConversionParams(ConversionOptions)
	
	JSONConversionParams = GetDefaultJSONConversionParams();
	If ValueIsFilled(ConversionOptions) Then
		For Each Option In ConversionOptions Do
			If JSONConversionParams.Property(Option.Key) Then
				JSONConversionParams.Insert(Option.Key, Option.Value);
			EndIf;
		EndDo;
	EndIf;
	
	Return JSONConversionParams;
	
EndFunction

Function AddJSONWritingParams(WritingOptions)
	
	JSONWritingParams = GetDefaultJSONWritingParams();
	If ValueIsFilled(WritingOptions) Then
		For Each Option In WritingOptions Do
			If JSONWritingParams.Property(Option.Key) Then
				JSONWritingParams.Insert(Option.Key, Option.Value);
			EndIf;
		EndDo;
	EndIf;
	
	Return JSONWritingParams;
	
EndFunction

#Region AuthenticationAWS4

Function GetAWS4SignatureKey(SecretKey, Date, Region, Service)
	
	DateKey = SignHMACMessage("AWS4" + SecretKey, Date);
	RegionKey = SignHMACMessage(DateKey, Region);
	ServiceKey = SignHMACMessage(RegionKey, Service);
	
	Return SignHMACMessage(ServiceKey, "aws4_request");
	
EndFunction

Function SignHMACMessage(Val KeyValue, Val Message, Val Algorithm = Undefined)
	
	If Algorithm = Undefined Then
		Algorithm = HashFunction.SHA256;
	EndIf;
	
	If TypeOf(KeyValue) = Type("String") Then
		KeyValue = GetBinaryDataFromString(KeyValue, TextEncoding.UTF8, False);
	EndIf;
	If TypeOf(Message) = Type("String") Then
		Message = GetBinaryDataFromString(Message, TextEncoding.UTF8, False);
	EndIf;

	Return HMAC(KeyValue, Message, Algorithm);
	
EndFunction

Procedure PrepareAuthenticationOfAWS4(PreparedRequest)

	HeaderValue = GetHeaderValue("x-amz-date", PreparedRequest.Headers);
	If HeaderValue <> False Then
		CurrentTime = Date(StrReplace(StrReplace(HeaderValue, "T", ""), "Z", ""));
	Else
		CurrentTime = CurrentUniversalDate();
	EndIf;
	PreparedRequest.Headers["x-amz-date"] = Format(CurrentTime, "DF=yyyyMMddTHHmmssZ");
	ScopeOfDate = Format(CurrentTime, "DF=yyyyMMdd");
	
	PreparedRequest.Headers["x-amz-content-sha256"] = 
		DataHashing(HashFunction.SHA256, PreparedRequest.HTTPRequest.GetBodyAsStream());
		
	URLStructure = DisassembleTheURL(PreparedRequest.URL);
	
	CanonicalHeaders = GetCanonicalAWS4Headers(PreparedRequest.Headers, URLStructure);
	
	CanonicalPath = URLStructure.Path;
	CanonicalRequestParameters = GetCanonicalParametersOfAWS4Request(URLStructure.RequestParams);
	
	RequestParts = New Array;
	RequestParts.Add(PreparedRequest.Method);
	RequestParts.Add(CanonicalPath);
	RequestParts.Add(CanonicalRequestParameters);
	RequestParts.Add(CanonicalHeaders.CanonicalHeaders);
	RequestParts.Add(CanonicalHeaders.SignedHeaders);
	RequestParts.Add(PreparedRequest.Headers["x-amz-content-sha256"]);
	CanonicalRequest = StrConcat(RequestParts, Chars.LF);
	
	PartsOfScope = New Array;
	PartsOfScope.Add(ScopeOfDate);
	PartsOfScope.Add(PreparedRequest.Authentication.State);
	PartsOfScope.Add(PreparedRequest.Authentication.Service);
	PartsOfScope.Add("aws4_request");
	Scope = StrConcat(PartsOfScope, "/");
	
	PartStringForSign = New Array;
	PartStringForSign.Add(PreparedRequest.Authentication.Type);
	PartStringForSign.Add(PreparedRequest.Headers["x-amz-date"]);
	PartStringForSign.Add(Scope);
	PartStringForSign.Add(DataHashing(HashFunction.SHA256, CanonicalRequest));
	StringForSign = StrConcat(PartStringForSign, Chars.LF);
	
	KeyValue = GetAWS4SignatureKey(
		PreparedRequest.Authentication.SecretKey,
		ScopeOfDate,
		PreparedRequest.Authentication.State,
		PreparedRequest.Authentication.Service);
	Sign = Lower(GetHexStringFromBinaryData(SignHMACMessage(KeyValue, StringForSign)));
	
	PreparedRequest.Headers["Authorization"] = StrTemplate(
		"%1 Credential=%2/%3, SignedHeaders=%4, Signature=%5",
		PreparedRequest.Authentication.Type,
		PreparedRequest.Authentication.AccessKeyID,
		Scope,
		CanonicalHeaders.SignedHeaders,
		Sign);
	
	PreparedRequest.HTTPRequest.Headers = PreparedRequest.Headers;

EndProcedure

Function IsStandartPort(URLStructure)
	
	StandardPortHTTP = 80;
	StandardPortHTTPS = 443;
	
	Return (URLStructure.Scheme = "http" And URLStructure.Port = StandardPortHTTP) 
		Or (URLStructure.Scheme = "https" And URLStructure.Port = StandardPortHTTPS);
	
EndFunction

Function HostHeaderValue(URLStructure)
	
	Host = URLStructure.Server;
	If ValueIsFilled(URLStructure.Port) And Not IsStandartPort(URLStructure) Then
		Host = Host + ":" + Format(URLStructure.Port, "NGS=; NG=");
	EndIf;
	
	Return Host;
	
EndFunction

Function GetCanonicalAWS4Headers(Headers, URLStructure)
	
	Список = New ValueList;
	
	HostHeaderInRequest = False;
	DefaultHeaders = AWS4DefaultHeaders();
	For Each CurrentHeader In Headers Do
		Header = Lower(CurrentHeader.Key);
		If DefaultHeaders.Exceptions.Find(Header) <> Undefined Then
			Continue;
		EndIf;
		HostHeaderInRequest = Max(HostHeaderInRequest, Header = "host");
		
		If DefaultHeaders.Equal.Find(Header) <> Undefined Then
			Список.Add(Header, TrimAll(CurrentHeader.Value));
		Else
			For Each Prefix In DefaultHeaders.BeginsWith Do
				If StrStartsWith(Header, Prefix) Then
					Список.Add(Header, TrimAll(CurrentHeader.Value));
					Break;
				EndIf;
			EndDo;
		EndIf;
	EndDo;
	
	If Not HostHeaderInRequest Then
		Список.Add("host", HostHeaderValue(URLStructure));
	EndIf;
	
	Список.SortByValue(SortDirection.Asc);
	
	CanonicalHeaders = New Array;
	SignedHeaders = New Array;
	For Each ЭлементСписка In Список Do
		CanonicalHeaders.Add(ЭлементСписка.Value + ":" + ЭлементСписка.Presentation);
		SignedHeaders.Add(ЭлементСписка.Value);
	EndDo;
	CanonicalHeaders.Add("");
	
	CanonicalHeaders = StrConcat(CanonicalHeaders, Chars.LF);
	SignedHeaders = StrConcat(SignedHeaders, ";");
	Return New Structure(
		"CanonicalHeaders, SignedHeaders",
		CanonicalHeaders, SignedHeaders);
	
EndFunction

Function GetCanonicalParametersOfAWS4Request(RequestParams)
	
	List = New ValueList;
	For Each CurrentParam In RequestParams Do
		List.Add(CurrentParam.Key, TrimAll(CurrentParam.Value));
	EndDo;
	List.SortByValue(SortDirection.Asc);
	
	CanonicalParams = New Array;
	For Each ListItem In List Do
		ParamValue = EncodeString(ListItem.Presentation, StringEncodingMethod.URLEncoding);
		CanonicalParams.Add(ListItem.Value + "=" + ParamValue);
	EndDo;
	
	Return StrConcat(CanonicalParams, "&");
		
EndFunction

Function AWS4DefaultHeaders()
	
	Headers = New Structure;
	Headers.Insert("Equal", StrSplit("host,content-type,date", ","));
	Headers.Insert("BeginsWith", StrSplit("x-amz-", ","));
	Headers.Insert("Exceptions", StrSplit("x-amz-client-context", ","));
	
	Return Headers;
	
EndFunction

#EndRegion

#Region CodingDataDecoding

#Region ServiceStructuresZip

// Description see here https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT

Function ZipSizeLFH()
	
	Return 34;
	
EndFunction

Function ZipSizeDD()
	
	Return 16;
	
EndFunction

Function ZipSizeCDH()
	
	Return 50;
	
EndFunction

Function ZipSizeEOCD()
	
	Return 22;
	
EndFunction

Function ZipLFH()
	
	// Local file header
	Buffer = New BinaryDataBuffer(ZipSizeLFH());
	Buffer.WriteInt32(0, 67324752); // signature 0x04034b50
	Buffer.WriteInt16(4, 20);       // version
	Buffer.WriteInt16(6, 10);       // bit flags	
	Buffer.WriteInt16(8, 8);        // compression method
	Buffer.WriteInt16(10, 0);       // time
	Buffer.WriteInt16(12, 0);       // date
	Buffer.WriteInt32(14, 0);       // crc-32
	Buffer.WriteInt32(18, 0);       // compressed size
	Buffer.WriteInt32(22, 0);       // uncompressed size
	Buffer.WriteInt16(26, 4);       // filename legth - "data"
	Buffer.WriteInt16(28, 0);       // extra field length
	Buffer.Write(30, GetBinaryDataBufferFromString("data", "ascii", False));
	
	Return Buffer;
	
EndFunction

Function ZipDD(CRC32, SizeOfCompressedData, SizeOfUncompressedData)
	
	// Data descriptor
	Buffer = New BinaryDataBuffer(ZipSizeDD());
	Buffer.WriteInt32(0, 134695760);
	Buffer.WriteInt32(4, CRC32);
	Buffer.WriteInt32(8, SizeOfCompressedData);
	Buffer.WriteInt32(12, SizeOfUncompressedData);
	
	Return Buffer;
	
EndFunction

Function ZipCDH(CRC32, SizeOfCompressedData, SizeOfUncompressedData)
	
	// Central directory header
	Buffer = New BinaryDataBuffer(ZipSizeCDH());
	Buffer.WriteInt32(0, 33639248);              // signature 0x02014b50
	Buffer.WriteInt16(4, 798);                   // version made by
	Buffer.WriteInt16(6, 20);                    // version needed to extract
	Buffer.WriteInt16(8, 10);                    // bit flags
	Buffer.WriteInt16(10, 8);                    // compression method
	Buffer.WriteInt16(12, 0);                    // time
	Buffer.WriteInt16(14, 0);                    // date
	Buffer.WriteInt32(16, CRC32);                // crc-32
	Buffer.WriteInt32(20, SizeOfCompressedData);   // compressed size
	Buffer.WriteInt32(24, SizeOfUncompressedData); // uncompressed size
	Buffer.WriteInt16(28, 4);                    // file name length
	Buffer.WriteInt16(30, 0);                    // extra field length
	Buffer.WriteInt16(32, 0);                    // file comment length
	Buffer.WriteInt16(34, 0);                    // disk number start
	Buffer.WriteInt16(36, 0);                    // internal file attributes
	Buffer.WriteInt32(38, 2176057344);           // external file attributes
	Buffer.WriteInt32(42, 0);                    // relative offset of local header
	Buffer.Write(46, GetBinaryDataBufferFromString("data", "ascii", False));
	
	Return Buffer;

EndFunction

Function ZipEOCD(SizeOfCompressedData)
	
	// End of central directory
	CDHSize = 50;
	Buffer = New BinaryDataBuffer(ZipSizeEOCD());
	Buffer.WriteInt32(0, 101010256); // signature 0x06054b50
	Buffer.WriteInt16(4, 0); // number of this disk
	Buffer.WriteInt16(6, 0); // number of the disk with the start of the central directory
	Buffer.WriteInt16(8, 1); // total number of entries in the central directory on this disk
	Buffer.WriteInt16(10, 1); // total number of entries in the central directory
	Buffer.WriteInt32(12, CDHSize); // size of the central directory	
	// offset of start of central directory with respect to the starting disk number
	Buffer.WriteInt32(16, ZipSizeLFH() + SizeOfCompressedData + ZipSizeDD()); 
	Buffer.WriteInt16(20, 0); // the starting disk number
	
	Return Buffer;
	
EndFunction

#EndRegion

#Region ServiceStructuresGZip

// Описание структур см. здесь https://www.ietf.org/rfc/rfc1952.txt

Function GZipSizeHeader()

	Return 10;

EndFunction

Function GZipSizeFooter()

	Return 8;

EndFunction

Function GZipHeader()

	Buffer = New BinaryDataBuffer(GZipSizeHeader());
	Buffer[0] = 31;               // ID1 0x1f
	Buffer[1] = 139;              // ID2 0x8b
	Buffer[2] = 8;                // compression method (08 for DEFLATE)
	Buffer[3] = 0;                // header flags
	Buffer.WriteInt32(4, 0); // timestamp
	Buffer[8] = 0;                // compression flags
	Buffer[9] = 255;              // operating system ID

	Return Buffer;

EndFunction

Function GZipFooter(CRC32, SizeOfTheOriginalData)
	
	Buffer = New BinaryDataBuffer(GZipSizeFooter());
	Buffer.WriteInt32(0, CRC32);
	Buffer.WriteInt32(4, SizeOfTheOriginalData);

	Return Buffer;

EndFunction

#EndRegion

Function ReadZip(CondensedData, ErrorText = Undefined)
	
#If MobileAppServer Then
	Raise(NStr("ru = 'Работа с Zip-файлами в мобильной платформе не поддерживается';
							|En = 'Work with ZIP-files in mobile platform unsupported';"));
#Else
	Catalog = GetTempFileName();
	ZipFileReader = New ZipFileReader(CondensedData);
	FileName = ZipFileReader.Items[0].Name;
	Try
		ZipFileReader.Extract(ZipFileReader.Items[0], Catalog, ZIPRestoreFilePathsMode.DontRestore);
	Except
		// Ignore the integrity of the archive, just read the result
		ErrorText = DetailErrorDescription(ErrorInfo());
	EndTry;
	ZipFileReader.Close();
	
	Result = New BinaryData(Catalog + GetPathSeparator() + FileName);
	DeleteFiles(Catalog);
	
	Return Result;
#EndIf
	
EndFunction

Function WriteZip(Data)

#If MobileAppServer Then
	Raise(NStr("ru = 'Работа с Zip-файлами в мобильной платформе не поддерживается';
							|En = 'Work with ZIP-files in mobile platform unsupported';"));
#Else
	TempFile = GetTempFileName(".bin");
	Data.Write(TempFile);
	ZipStream = New MemoryStream;
	ZipFileWriter = New ZipFileWriter(ZipStream);
	ZipFileWriter.Add(TempFile);
	ZipFileWriter.Write();
	DeleteFiles(TempFile);

	Return ZipStream.CloseAndGetBinaryData();
#EndIf

EndFunction

#EndRegion

#Region EventHandlers

Procedure ProcessingResponseWithCode401(Session, PreparedRequest, Settings, Response)
	
	If IsRedirect(Response.StatusCode, Response.Headers) Then
		Return;
	EndIf;
	
	HTTPStatusCodes = HTTPStatusCodes();
	If Response.StatusCode < HTTPStatusCodes.BadRequest_400 
		Or Response.StatusCode >= HTTPStatusCodes.InternalServerError_500 Then
		Return;
	EndIf;
	
	Value = GetHeaderValue("www-authenticate", Response.Headers);
	If Value <> False And StrFind(Lower(Value), "digest") Then
		Position = StrFind(Lower(Value), "digest");
		Value = Mid(Value, Position + StrLen("digest") + 1);
		Value = StrReplace(Value, """", "");
		Value = StrReplace(Value, Chars.LF, "");
		
		DigestParams = New Structure("algorithm,realm,nonce,qop,opaque");
		For Each Part In SplitStringByString(Value, ", ") Do
			KeyValue = StrSplit(Part, "=");
			DigestParams.Insert(KeyValue[0], KeyValue[1]);
		EndDo;
		
		Session.ServiceData.DigestParams = DigestParams;
		
		PreparedRequest.Headers.Insert("Authorization", PrepareHeaderDigest(Session, PreparedRequest));
		PreparedRequest.HTTPRequest.Headers = PreparedRequest.Headers;
		
		Response = SendHTTPRequest(Session, PreparedRequest, Settings);
	EndIf;
	
EndProcedure

Function DefineHashFunction(Val Algorithm)
	
	Algorithm = Upper(Algorithm);
	If Not ValueIsFilled(Algorithm) Or Algorithm = "MD5" Or Algorithm = "MD5-SESS" Then
		Return HashFunction.MD5;
	ElsIf Algorithm = "SHA" Then
		Return HashFunction.SHA1;
	ElsIf Algorithm = "SHA-256" Then
		Return HashFunction.SHA256;
	Else
		Return Undefined;
	EndIf;
	
EndFunction

Function PrepareHeaderDigest(Session, PreparedRequest)
	
	DigestParams = Session.ServiceData.DigestParams;
	
	Algorithm = DefineHashFunction(DigestParams.algorithm);
	AlgorithmString = Upper(DigestParams.algorithm);
	If Algorithm = Undefined Then
		Return Undefined;
	EndIf;
	
	URLStructure = DisassembleTheURL(PreparedRequest.URL);
	Path = URLStructure.Path;
	If ValueIsFilled(URLStructure.RequestParams) Then
		Path = Path + "?" + EncodeRequestParams(URLStructure.RequestParams);
	EndIf;
	
	A1 = StrTemplate("%1:%2:%3", 
		PreparedRequest.Authentication.User,
		DigestParams.realm,
		PreparedRequest.Authentication.Password);
	A2 = StrTemplate("%1:%2", PreparedRequest.Method, Path);
	
	HA1 = DataHashing(Algorithm, A1);
	HA2 = DataHashing(Algorithm, A2);
	
	If Not DigestParams.Property("last_nonce") Then
		DigestParams.Insert("last_nonce");
	EndIf;
	
	If DigestParams.nonce = DigestParams.last_nonce Then
		DigestParams.nonce_count = DigestParams.nonce_count + 1;
	Else
		DigestParams.Insert("nonce_count", 1);
	EndIf;
	
	NCValue = Format(DigestParams.nonce_count, "ND=8; NLZ=; NG=");
	NonceValue = Left(StrReplace(Lower(New UUID), "-", ""), 16);

	If AlgorithmString = "MD5-SESS" Then
		HA1 = DataHashing(Algorithm, StrTemplate("%1:%2:%3", HA1, DigestParams.nonce, NonceValue)); 
	EndIf;
	
	If Not ValueIsFilled(DigestParams.qop) Then
		ResponseValue = DataHashing(Algorithm, StrTemplate("%1:%2:%3", HA1, DigestParams.nonce, HA2));
	ElsIf DigestParams.qop = "auth"
		Or StrSplit(DigestParams.qop, ",", False).Find("auth") <> Undefined Then
		NonceBitValue = StrTemplate("%1:%2:%3:%4:%5", DigestParams.nonce, NCValue, NonceValue, "auth", HA2);
		ResponseValue = DataHashing(Algorithm, StrTemplate("%1:%2", HA1, NonceBitValue));
	Else
		// INFO: auth-int not implemented
		Return Undefined;
	EndIf;
	
	DigestParams.last_nonce = DigestParams.nonce;

	Base = StrTemplate("username=""%1"", realm=""%2"", nonce=""%3"", uri=""%4"", response=""%5""", 
		PreparedRequest.Authentication.User,
		DigestParams.realm,
		DigestParams.nonce,
		Path,
		ResponseValue);
	Strings = New Array;
	Strings.Add(Base);
		
	If ValueIsFilled(DigestParams.opaque) Then
		Strings.Add(StrTemplate(", opaque=""%1""", DigestParams.opaque));
	EndIf;
	If ValueIsFilled(DigestParams.algorithm) Then
		Strings.Add(StrTemplate(", algorithm=""%1""", DigestParams.algorithm));
	EndIf;
	If ValueIsFilled(DigestParams.qop) Then
		Strings.Add(StrTemplate(", qop=""auth"", nc=%1, cnonce=""%2""", NCValue, NonceValue));
	EndIf;
	
	Return StrTemplate("Digest %1", StrConcat(Strings, ""));
	
EndFunction

Function DataHashing(Val Algorithm, Val Data)
	
	If TypeOf(Data) = Type("String") Then
		Data = GetBinaryDataFromString(Data, TextEncoding.UTF8, False);
	EndIf;
	
	Hashing = New DataHashing(Algorithm);
	Hashing.Append(Data);
	
	Return Lower(GetHexStringFromBinaryData(Hashing.HashSum));
	
EndFunction

Function SplitStringByString(Val String, Delimeter)
	
	Result = New Array;
	While True Do
		Position = StrFind(String, Delimeter);
		If Position = 0 And ValueIsFilled(String) Then
			Result.Add(String);
			Break;
		EndIf;
		
		FistPart = Left(String, Position - StrLen(Delimeter) + 1);
		Result.Add(FistPart);
		String = Mid(String, Position + StrLen(Delimeter));
	EndDo;
	
	Return Result;
	
EndFunction

#EndRegion

Function ExtractResponse(Response)
	
	Header = GetHeaderValue("content-encoding", Response.Headers);
	If Header <> False Then
		If Lower(Header) = "gzip" Then
			Return ReadGZIP(Response.Body);
		EndIf;
	EndIf;
	
	Return Response.Body;
	
EndFunction

Procedure WrapRequest(Request)

	Header = GetHeaderValue("content-encoding", Request.Headers);
	If Header <> False Then
		If Lower(Header) = "gzip" Then
			Request.SetBodyFromBinaryData(WriteGzip(Request.GetBodyAsBinaryData()));
		EndIf;
	EndIf;

EndProcedure

#Region DefaultValues

Function DefaultHeaders()
	
	Headers = New Map;
#If MobileAppServer Then
	Headers.Insert("Accept-Encoding", "identity");
#Else
	Headers.Insert("Accept-Encoding", "gzip");
#EndIf
	Headers.Insert("Accept", "*/*");
	Headers.Insert("Connection", "keep-alive");
	
	Return Headers;
	
EndFunction

Function MaximumNumberOfRedirects()
	
	Return 30;
	
EndFunction

Function StandardTimeout()
	
	Return 30;
	
EndFunction

Function GetDefaultJSONConversionParams()
	
	DefaultJSONConversionParams = New Structure;
	DefaultJSONConversionParams.Insert("ReadInMap", True);
	DefaultJSONConversionParams.Insert("JSONDateFormat", JSONDateFormat.ISO);
	DefaultJSONConversionParams.Insert("PropertyNamesWithDateValues", Undefined);
	
	Return DefaultJSONConversionParams;
	
EndFunction

Function GetDefaultJSONWritingParams()
	
	DefaultJSONWritingParams = New Structure;
	DefaultJSONWritingParams.Insert("NewLines", JSONLineBreak.Auto);
	DefaultJSONWritingParams.Insert("PaddingSymbols", " ");
	DefaultJSONWritingParams.Insert("UseDoubleQuotes", True);
	DefaultJSONWritingParams.Insert("EscapeCharacters", JSONCharactersEscapeMode.None);
	DefaultJSONWritingParams.Insert("EscapeAngleBrackets", False);
	DefaultJSONWritingParams.Insert("EscapeLineTerminators", True);
	DefaultJSONWritingParams.Insert("EscapeAmpersand", False);
	DefaultJSONWritingParams.Insert("EscapeSingleQuotes", False);
	DefaultJSONWritingParams.Insert("EscapeSlash", False);
	
	Return DefaultJSONWritingParams;
	
EndFunction

#EndRegion

Procedure FillAdditionalParams(AdditionalParams, RequestParams, Data, Json)

	If AdditionalParams = Undefined Then
		AdditionalParams = New Structure();
	EndIf;
	If Not AdditionalParams.Property("RequestParams") Then
		AdditionalParams.Insert("RequestParams", RequestParams);
	EndIf;
	If Not AdditionalParams.Property("Data") Then
		AdditionalParams.Insert("Data", Data);
	EndIf;
	If Not AdditionalParams.Property("Json") Then
		AdditionalParams.Insert("Json", Json);
	EndIf;

EndProcedure

// Someday there will be a pause in the platform and it can be thrown out
//
Procedure Pause(DurationInSecond)

	If DurationInSecond < 1 Then
		Return;
	EndIf;
	
	CurrentDate = CurrentUniversalDate();
	WaitUntil = CurrentDate + DurationInSecond;
	
	// BSLLS:UsingHardcodeNetworkAddress-off
	LocalHost = "127.0.0.0";
	SomeFreePort = 56476;
	// BSLLS:UsingHardcodeNetworkAddress-on
	While CurrentDate < WaitUntil Do
		Timeout = WaitUntil - CurrentDate;
		Start = CurrentUniversalDateInMilliseconds();
		Try
			Connection = New HTTPConnection(
				LocalHost, SomeFreePort, Undefined, Undefined, Undefined, Timeout);
			Connection.Get(New HTTPRequest("/does_not_matter"));
		Except
			RealTimeout = CurrentUniversalDateInMilliseconds() - Start;
		EndTry;
		MinimumTimeoutInMilliseconds = 1000;
		If RealTimeout < MinimumTimeoutInMilliseconds Then
			Raise(NStr("ru = 'Процедура Приостановить не работает должным образом';
									|En = 'Pause not work properly';"));
		EndIf;
		CurrentDate = CurrentUniversalDate();
	EndDo;
	
EndProcedure

#EndRegion
