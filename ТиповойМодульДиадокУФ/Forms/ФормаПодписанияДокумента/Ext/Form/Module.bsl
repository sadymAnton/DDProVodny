﻿
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

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	ДокументПодписан=	Ложь;
	
	Параметры.ПараметрыПодписания=	МетодСервера(,"ПолучитьПараметрыПодписанияТ12вДиадок", Параметры.Организация);
	
	Организация=			Параметры.Организация;
	ПредставлениеДокумента=	Параметры.ПредставлениеДокумента;
	ПредставлениеПодписи=	Параметры.ПредставлениеПодписи;
	ЭДОбъектType=			Параметры.ЭДОбъектType;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);

	Если ЭДОбъектType = "XmlTorg12" Тогда
		Заголовок=	"Подписание товарной накладной";
		Элементы.ДатаПолученияГруза.Заголовок=	"Дата получения";
	Иначе
		Заголовок=	"Подписание акта выполненных работ";
		Элементы.ДатаПолученияГруза.Заголовок=	"Дата приема";
		Элементы.ГруппаГрузополучателя.Заголовок = "Работы принял";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПредставлениеДокумента) Тогда
		Элементы.ПредставлениеДокумента.Заголовок=	ПредставлениеДокумента;
	Иначе
		Элементы.ПредставлениеДокумента.Видимость=	Ложь;
		Заголовок=	"Групповое подписание документов";
	КонецЕсли;
	
	ФИОПодписанта=			Параметры.ПараметрыПодписания.ФИОПодписанта;
	ДолжностьПодписанта=	Параметры.ПараметрыПодписания.ДолжностьПодписанта;
	ДатаПолученияГруза=		ТекущаяДата();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

&НаКлиенте
Процедура Отменить(Команда)
	
	ЭтаФорма.Закрыть();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДолжностьПодписанта(ПараметрыПодписания)

	МетодСервера(,"УстановитьПараметрыПодписанияТ12вДиадок", ПараметрыПодписания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодписатьИОтправить(Команда)
	
	СписокНезаполненныхПолей = "";
	
	Если НЕ ЗначениеЗаполнено(ДатаПолученияГруза) Тогда
		СписокНезаполненныхПолей=	СписокНезаполненныхПолей + "дата получения груза";
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ДолжностьПодписанта) Тогда 
		СписокНезаполненныхПолей=	?(СписокНезаполненныхПолей = "", "", СписокНезаполненныхПолей+", ") +"должность";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СписокНезаполненныхПолей) Тогда
		ПоказатьПредупреждение(, 
		?(Найти(СписокНезаполненныхПолей, ",")=0, "Не заполнено обязательное поле:", "Не заполнены обязательные поля:")+"
		|"+ СписокНезаполненныхПолей, 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
		Возврат;
	КонецЕсли;	
	
	Если ДолжностьПодписанта<>Параметры.ПараметрыПодписания.ДолжностьПодписанта Тогда
		Параметры.ПараметрыПодписания.ДолжностьПодписанта=	ДолжностьПодписанта;
		УстановитьДолжностьПодписанта(Параметры.ПараметрыПодписания);
	КонецЕсли;	
	
	Результат=	Новый Структура();
	Результат.Вставить("ДокументПодписан",		Истина);
	Результат.Вставить("ДатаПолученияГруза",	ДатаПолученияГруза);
	Результат.Вставить("ФИОПодписанта",			ФИОПодписанта);
	Результат.Вставить("ДолжностьПодписанта",	ДолжностьПодписанта);
	
	Закрыть(Результат);
	
КонецПроцедуры
