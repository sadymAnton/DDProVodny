﻿//{ ПЕРЕМЕННЫЕ МОДУЛЯ

	&НаКлиенте
	Перем ВнесеныИзменения;
	
	&НаКлиенте
	Перем ПараметрЗакрытия;
	
//} ПЕРЕМЕННЫЕ МОДУЛЯ

#Область ПЕРМЕННЫЕ_ПЛАТФОРМЫ

&НаКлиенте
Перем Платформа Экспорт;

&НаСервере
Перем ОбработкаОбъект;

#КонецОбласти

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ПЛАТФОРМЫ

&НаКлиенте
Функция МетодКлиента(ИмяМодуля= "", ИмяМетода, 
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL,
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат  Платформа.МетодКлиента(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаКлиенте
Функция МетодСервераБезКонтекста(ИмяМодуля= "", ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат Платформа.МетодСервераБезКонтекста(ИмяМодуля, ИмяМетода,
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция МетодСервера(Знач ИмяМодуля= "", Знач ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат ОбработкаОбъект().МетодСервера(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект() Экспорт
	
	Если ОбработкаОбъект = Неопределено Тогда
		
		СтруктураОбработки= ПолучитьИзВременногоХранилища(Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
		
		Если СтруктураОбработки <> Неопределено Тогда
			ОбработкаОбъект= СтруктураОбработки.ОбработкаОбъект;
		КонецЕсли;
		
		Если ОбработкаОбъект = Неопределено Тогда
			
			ОбработкаОбъект= РеквизитФормыВЗначение("Объект");
			
			Попытка
				ПоместитьВоВременноеХранилище(Новый Структура("ОбработкаОбъект", ОбработкаОбъект), Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
			Исключение КонецПопытки;
		
		Иначе
			ОбработкаОбъект.ПараметрыКлиентСервер= Объект.ПараметрыКлиентСервер;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ОбработкаОбъект;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма(ТекущийВладелецФормы)
	
	Если ТекущийВладелецФормы = Неопределено Тогда
		Возврат Неопределено
	ИначеЕсли Прав(ТекущийВладелецФормы.ИмяФормы, 14) = "Форма_Основная" Тогда
		Возврат ТекущийВладелецФормы;
	Иначе
		Возврат ОсновнаяФорма(ТекущийВладелецФормы.ВладелецФормы);
	КонецЕсли;
	
КонецФункции


&НаСервере
Процедура ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ОбъектПараметрыКлиентСервер", Объект.ПараметрыКлиентСервер);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриОткрытии(Отказ)
	
	ОсновнаяФорма= ОсновнаяФорма(ВладелецФормы);
	
	Если ОсновнаяФорма <> Неопределено Тогда
		Платформа= ОсновнаяФорма.Платформа;
	КонецЕсли;
		
	Платформа.ПриОткрытииФормыОбработки(ЭтаФорма, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриЗакрытии()
	
	Платформа.ПриЗакрытииФормыОбработки(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ТаблицаКонтрагентов1СПодразделениеКонтрагентаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка=	Ложь;
	ДобавитьПодразделение();
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	CounteragentID=	Параметры.CounteragentID;
	ИНН=			Параметры.ИНН;
	НаименованиеДД= Параметры.НаименованиеДД;
	Организация=    Параметры.Организация;
	КонтрагентФормироватьУПД = Неопределено;
	
	Для каждого СтрокаКонтрагента Из Параметры.СписокКонтрагентовВ1С.ПолучитьЭлементы() Цикл
		
		СтрокаКонтрагентаВ1С=							СписокКонтрагентовВ1С.ПолучитьЭлементы().Добавить();
		СтрокаКонтрагентаВ1С.Представление=				СтрокаКонтрагента.КонтрагентВ1С;
		СтрокаКонтрагентаВ1С.КонтрагентВ1С=				СтрокаКонтрагента.КонтрагентВ1С;
		СтрокаКонтрагентаВ1С.ПодразделениеКонтрагента=	СтрокаКонтрагента.ПодразделениеКонтрагента;
		СтрокаКонтрагентаВ1С.ToDepartmentID=			СтрокаКонтрагента.ToDepartmentID;

		Если КонтрагентФормироватьУПД = Неопределено Тогда
			КонтрагентФормироватьУПД = СтрокаКонтрагента.КонтрагентВ1С;
		КонецЕсли;

		Для каждого СтрокаДоговора Из СтрокаКонтрагента.ПолучитьЭлементы() Цикл
			
			СтрокаДоговораВ1С=							СтрокаКонтрагентаВ1С.ПолучитьЭлементы().Добавить();
			СтрокаДоговораВ1С.Представление=			СтрокаДоговора.Договор;
			СтрокаДоговораВ1С.Договор=					СтрокаДоговора.Договор;
			СтрокаДоговораВ1С.КонтрагентВ1С=			СтрокаДоговора.КонтрагентВ1С;
			СтрокаДоговораВ1С.ПодразделениеКонтрагента=	СтрокаДоговора.ПодразделениеКонтрагента;
			СтрокаДоговораВ1С.ToDepartmentID=			СтрокаДоговора.ToDepartmentID;
			
		КонецЦикла;
		
	КонецЦикла;

	Если ЗначениеЗаполнено(КонтрагентФормироватьУПД) Тогда
		ФормироватьУПД = МетодСервера(,"ПолучитьЗначениеСвойства", КонтрагентФормироватьУПД, "ДиадокФормироватьУПДКонтрагент");
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УстановитьCounteragentBoxID(id,  ВыбКонтрагент)
	
	МетодСервера(,"Установить_CounteragentBoxID_для_Контрагент", ВыбКонтрагент, id);
	
КонецПроцедуры

&НаСервере
Функция УстановитьПараметрыМаршрутизацииДляДоговора(Договор, НаименованиеПодразделения, ИДПодразделения)
	
	МетодСервера(,"УстановитьПараметрыМаршрутизацииДляДоговора", Договор, НаименованиеПодразделения, ИДПодразделения);
	
КонецФункции

&НаСервере
Функция УстановитьПараметрыМаршрутизацииДляКонтрагента(Контрагент, НаименованиеПодразделения, ИДПодразделения)
	
	МетодСервера(,"УстановитьПараметрыМаршрутизацииДляКонтрагента", Контрагент,,НаименованиеПодразделения, ИДПодразделения);
	
КонецФункции

&НаКлиенте
Функция ОчиститьПараметрыМаршрутизации(ТекущиеДанные)
	
	Если ЗначениеЗаполнено(ТекущиеДанные.Договор) Тогда
		УстановитьПараметрыМаршрутизацииДляДоговора(ТекущиеДанные.Договор, "", "");
	Иначе
		УстановитьCounteragentBoxID("", ТекущиеДанные.КонтрагентВ1С);
		УстановитьПараметрыМаршрутизацииДляКонтрагента(ТекущиеДанные.КонтрагентВ1С, "", "");
	КонецЕсли;
	
	Для каждого ЭлементДанных Из ТекущиеДанные.ПолучитьЭлементы() Цикл
		ОчиститьПараметрыМаршрутизации(ЭлементДанных);
	КонецЦикла;
	
КонецФункции

&НаКлиенте
Процедура ТаблицаКонтрагентов1СПередУдалением(Элемент, Отказ)
	
	ВнесеныИзменения=	Истина;
	
	ТекущиеДанные=	Элементы.ТаблицаКонтрагентов1С.ТекущиеДанные;
	ОчиститьПараметрыМаршрутизации(ТекущиеДанные);
	
КонецПроцедуры

&НаСервере
Функция ДоговорДобавленВДерево(ВыбранныйДоговор) Экспорт
	
	ДеревоКонтрагентов=	РеквизитФормыВЗначение("СписокКонтрагентовВ1С");
	Если ДеревоКонтрагентов.Строки.Найти(ВыбранныйДоговор, "Договор", Истина) = Неопределено Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция КонтрагентДобавленВДерево(ВыбранныйКонтрагент) Экспорт
	
	ДеревоКонтрагентов=	РеквизитФормыВЗначение("СписокКонтрагентовВ1С");
	Если ДеревоКонтрагентов.Строки.Найти(ВыбранныйКонтрагент, "КонтрагентВ1С", Истина) = Неопределено Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
//{ ВЫБОР ЕСТЬ
	
	&НаКлиенте
	Процедура ДобавитьДоговор()
		
		ТекущиеДанные=	Элементы.ТаблицаКонтрагентов1С.ТекущиеДанные;
		
		Если ТекущиеДанные = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		ПараметрыФормы=	Новый Структура("Отбор", Новый Структура);
		ПараметрыФормы.Отбор.Вставить("Организация", Организация);
		Если Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "БГУ20"
			ИЛИ Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УТ11" Тогда
			ПараметрыФормы.Отбор.Вставить("Контрагент", ТекущиеДанные.КонтрагентВ1С);
		Иначе
			ПараметрыФормы.Отбор.Вставить("Владелец", ТекущиеДанные.КонтрагентВ1С);
		КонецЕсли;
		
		Если Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УТ11"
			ИЛИ Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "БП30" Тогда
			ИмяФормыВыбора= "Справочник.ДоговорыКонтрагентов.ФормаВыбора";
		Иначе
			ИмяФормыВыбора= "Справочник.Договоры.ФормаВыбора";
		КонецЕсли;
		
		МетодКлиента(,"ОткрытьФормуОбъектаИБМодально",,ИмяФормыВыбора, ПараметрыФормы, ЭтаФорма, "ОбработчикОткрытиеФормыВыбораДоговора", ТекущиеДанные);
		
	КонецПроцедуры

	&НаКлиенте
	Процедура ДобавитьКонтрагента()
		
		ПараметрыФормы=	Новый Структура("Отбор", Новый Структура);
		ПараметрыФормы.Отбор.Вставить("Ссылка", ПолучитьСписокКонтрагентовПоИНН(ИНН));
		
		Если Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УНФ16" Тогда
			ПараметрыФормы.Вставить("РежимВыбора", Истина);	
		КонецЕсли;
		
		МетодКлиента(,"ОткрытьФормуОбъектаИБМодально",,"Справочник.Контрагенты.ФормаВыбора", ПараметрыФормы, ЭтаФорма, "ОбработчикОткрытиеФормыВыбораКонтрагента");
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ДобавитьПодразделение()
		
		ТекущиеДанные=	Элементы.ТаблицаКонтрагентов1С.ТекущиеДанные;
		
		Organization = МетодКлиента("Модуль_Клиент","ПолучитьЯщикДиадокДляОрганизации", Организация);
		Если Organization = Неопределено Тогда 
			Отказ=	Истина;
			ПоказатьПредупреждение(, "Не удалось получить Организацию " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы, 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			Возврат;
		КонецЕсли;
		
		ТекущийDepartmentId=	?(ТекущиеДанные.ToDepartmentID = Неопределено, "", ТекущиеДанные.ToDepartmentID);
		
		ПараметрыФормы=	Новый Структура();
		ПараметрыФормы.Вставить("DepartmentId", 	ТекущийDepartmentId);
		ПараметрыФормы.Вставить("OrganizationId", 	Organization.ID);
		ПараметрыФормы.Вставить("CounteragentID", 	CounteragentID);
		
		МетодКлиента(,"ОткрытьФормуОбработкиМодально", "ВыборПодразделенияОрганизации", ПараметрыФормы, ЭтаФорма, "ОбработчикОткрытиеФормыВыбораПодразделенияОрганизации", ТекущиеДанные);

	КонецПроцедуры
	
//} ВЫБОРА НЕТ
////////////////////////////////////////////////////////////////////////////////

&НаКлиенте
Процедура ОбработчикОткрытиеФормыВыбораПодразделенияОрганизации(РезультатЗакрытия, ТекущиеДанные) Экспорт
	
	Если НЕ РезультатЗакрытия = Неопределено Тогда
		Если НЕ РезультатЗакрытия.DepartmentID = ТекущиеДанные.ToDepartmentID Тогда
			
			ТекущиеДанные.ПодразделениеКонтрагента=	РезультатЗакрытия.DepartmentName;
			ТекущиеДанные.ToDepartmentID=			РезультатЗакрытия.DepartmentID;
			
			Если ЗначениеЗаполнено(ТекущиеДанные.Договор) Тогда
				УстановитьПараметрыМаршрутизацииДляДоговора(ТекущиеДанные.Договор, ТекущиеДанные.ПодразделениеКонтрагента, ТекущиеДанные.ToDepartmentID);
			Иначе
				УстановитьПараметрыМаршрутизацииДляКонтрагента(ТекущиеДанные.КонтрагентВ1С, ТекущиеДанные.ПодразделениеКонтрагента, ТекущиеДанные.ToDepartmentID);
			КонецЕсли;
			
			ВнесеныИзменения=	Истина;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОткрытиеФормыВыбораДоговора(ВыбранныйДоговор, ТекущиеДанные) Экспорт
	
	Если НЕ ВыбранныйДоговор = Неопределено Тогда
		Если ДоговорДобавленВДерево(ВыбранныйДоговор) Тогда
			СообщениеПользователю=			Новый СообщениеПользователю;
			СообщениеПользователю.Текст=	"Договор уже добавлен в таблицу маршрутизации";
			СообщениеПользователю.Сообщить();
		Иначе
			
			Если ТекущиеДанные.ПолучитьРодителя() = Неопределено Тогда
				СтрокаДоговора=	ТекущиеДанные.ПолучитьЭлементы().Добавить();
			Иначе
				СтрокаДоговора=	ТекущиеДанные.ПолучитьРодителя().ПолучитьЭлементы().Добавить();
			КонецЕсли;
			
			СтрокаДоговора.Представление=	ВыбранныйДоговор;
			СтрокаДоговора.КонтрагентВ1С=	ТекущиеДанные.КонтрагентВ1С;
			СтрокаДоговора.Договор=			ВыбранныйДоговор;
			
			УстановитьПараметрыМаршрутизацииДляДоговора(СтрокаДоговора.Договор, СтрокаДоговора.ПодразделениеКонтрагента, СтрокаДоговора.ToDepartmentID);
			
			Элементы.ТаблицаКонтрагентов1С.ТекущаяСтрока=	СтрокаДоговора.ПолучитьИдентификатор();
			
			ВнесеныИзменения=	Истина;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОткрытиеФормыВыбораКонтрагента(ВыбранныйКонтрагент, ТекущиеДанные) Экспорт
	
	Если НЕ ВыбранныйКонтрагент = Неопределено Тогда
		Если КонтрагентДобавленВДерево(ВыбранныйКонтрагент) Тогда
			
			СообщениеПользователю=			Новый СообщениеПользователю;
			СообщениеПользователю.Текст=	"Контрагент уже добавлен в таблицу маршрутизации";
			СообщениеПользователю.Сообщить();
			
		Иначе
			
			СтрокаКонтрагента=					СписокКонтрагентовВ1С.ПолучитьЭлементы().Добавить();
			СтрокаКонтрагента.Представление=	ВыбранныйКонтрагент;
			СтрокаКонтрагента.КонтрагентВ1С=	ВыбранныйКонтрагент;
			
			УстановитьCounteragentBoxID(CounteragentID, ВыбранныйКонтрагент);
			
			Элементы.ТаблицаКонтрагентов1С.ТекущаяСтрока=	СтрокаКонтрагента.ПолучитьИдентификатор();
			
			ВнесеныИзменения=	Истина;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаКонтрагентов1СПередНачаломИзменения(Элемент, Отказ)
	
	Если Элементы.ТаблицаКонтрагентов1С.ТекущийЭлемент.Имя = "ТаблицаКонтрагентов1СКонтрагентВ1С" Тогда
		ДобавитьКонтрагента();
	ИначеЕсли Элементы.ТаблицаКонтрагентов1С.ТекущийЭлемент.Имя = "ТаблицаКонтрагентов1СПодразделениеКонтрагента" Тогда
		ДобавитьПодразделение();
	КонецЕсли;
	
	Отказ=	Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаКонтрагентов1СПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	ДобавитьКонтрагента();
	Отказ=	Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьДоговорКоманда(Команда)
	
	ДобавитьДоговор();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);

	Для каждого СтрокаТаблицы Из СписокКонтрагентовВ1С.ПолучитьЭлементы() Цикл
		Элементы.ТаблицаКонтрагентов1С.Развернуть(СтрокаТаблицы.ПолучитьИдентификатор(), Истина);
	КонецЦикла;
	
	ЭтаФорма.Элементы.НаименованиеДД.Заголовок = "Контрагент в " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если ПараметрЗакрытия = Неопределено Тогда
		
		ПараметрЗакрытия= Новый Структура;
		ПараметрЗакрытия.Вставить("ВнесеныИзменения"	 , ВнесеныИзменения);
		ПараметрЗакрытия.Вставить("СписокКонтрагентовВ1С", СписокКонтрагентовВ1С);

		УстановитьНастройку_ФормироватьУПД();

		Закрыть(ПараметрЗакрытия);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСписокКонтрагентовПоИНН(ИНН)
    
    Запрос = Новый Запрос;
    Запрос.Текст = 
        "ВЫБРАТЬ
        |    Контрагенты.Ссылка
        |ИЗ
        |    Справочник.Контрагенты КАК Контрагенты
        |ГДЕ
        |    Контрагенты.ИНН = &ИНН
        |    И НЕ Контрагенты.ПометкаУдаления";
    
    Запрос.УстановитьПараметр("ИНН", ИНН);
    
    РезультатЗапроса = Запрос.Выполнить();
    Если Не РезультатЗапроса.Пустой() Тогда 
        Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Ссылка");    
    Иначе 
        Возврат Новый Массив;
    КонецЕсли;    
    
КонецФункции

&НаСервере
Процедура УстановитьНастройку_ФормироватьУПД()

	Для Каждого СтрокаТаблицы ИЗ СписокКонтрагентовВ1С.ПолучитьЭлементы() Цикл
		Контрагент = СтрокаТаблицы.КонтрагентВ1С;
		Если ЗначениеЗаполнено(Контрагент) Тогда
			МетодСервера(,"УстановитьЗначениеСвойства", Контрагент, "ДиадокФормироватьУПДКонтрагент",, ФормироватьУПД);
		КонецЕсли;
	КонецЦикла;
		
КонецПроцедуры
