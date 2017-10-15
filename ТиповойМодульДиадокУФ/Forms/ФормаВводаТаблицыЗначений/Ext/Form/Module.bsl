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
Функция ПолучитьШаблонКлючейСервер()
	
	Возврат МетодСервера(,"ПолучитьШаблонКлючейДопСведений", IDОрганизации, DocumentType);
	
КонецФункции

&НаКлиенте
Процедура ВосстановитьШаблонПолей(Команда)
	
	ШаблонКлючей =	ПолучитьШаблонКлючейСервер();
	
	ЗагрузитьСтрокуКлючЗначение(ШаблонКлючей);
	
КонецПроцедуры

&НаСервере
Процедура СохранитьСтрокуКлючЗначениеСервер(Организация, DocumentType, СтрокаКлючЗначение)
	
	СловарьWL= МетодСервера(,"ПолучитьСловарь");
	
	ТаблицаКлючейЗначений=	ХранилищеОбщихНастроек.Загрузить(СловарьWL.НаименованиеСистемы, "ТаблицаОбязательныхЗначенийКлючей");
	Если ТаблицаКлючейЗначений <> Неопределено Тогда
		
		ОтборСтрок=			Новый Структура("Организация, DocumentType", Организация, DocumentType);
		НайденныеСтроки=	ТаблицаКлючейЗначений.НайтиСтроки(ОтборСтрок);
		Если НайденныеСтроки.Количество() > 0 Тогда
			НайденныеСтроки[0].СтрокаКлючЗначение=	СтрокаКлючЗначение;
		Иначе
			СтрокаТаблицы=	ТаблицаКлючейЗначений.Добавить();
			СтрокаТаблицы.Организация=			Организация;
			СтрокаТаблицы.DocumentType=			DocumentType;
			СтрокаТаблицы.СтрокаКлючЗначение=	СтрокаКлючЗначение;
		КонецЕсли;
		
	Иначе
		
		ТаблицаКлючейЗначений=	Новый ТаблицаЗначений;
		ТаблицаКлючейЗначений.Колонки.Добавить("Организация");
		ТаблицаКлючейЗначений.Колонки.Добавить("DocumentType");
		ТаблицаКлючейЗначений.Колонки.Добавить("СтрокаКлючЗначение");
		
		СтрокаТаблицы=	ТаблицаКлючейЗначений.Добавить();
		СтрокаТаблицы.Организация=			Организация;
		СтрокаТаблицы.DocumentType=			DocumentType;
		СтрокаТаблицы.СтрокаКлючЗначение=	СтрокаКлючЗначение;
		
	КонецЕсли;
	
	ХранилищеОбщихНастроек.Сохранить(СловарьWL.НаименованиеСистемы, "ТаблицаОбязательныхЗначенийКлючей", ТаблицаКлючейЗначений);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНастройкуКлючей(Команда)
	
	СтрокаКлючЗначение=	"";
	Для каждого СтрокаТаблицы Из ТабКлючиЗначения Цикл
		СтрокаКлючЗначение=	СтрокаКлючЗначение + СтрокаТаблицы.Ключ + "=" + СтрокаТаблицы.Значение + ";";
	КонецЦикла;
	
	Если ТабКлючиЗначения.Количество()<= 20 Тогда
		СохранитьСтрокуКлючЗначениеСервер(Организация, DocumentType, СтрокаКлючЗначение);
		
		Закрыть(СтрокаКлючЗначение);
	Иначе
		ПоказатьПредупреждение(, "Для документа не может быть указано больше 20 дополнительныйх свойств");
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСтрокуКлючЗначение(Знач ОригинальнаяСтрока)
	
	ТабКлючиЗначения.Очистить();
	
	Пока НЕ ОригинальнаяСтрока = "" Цикл
		
		КлючИЗначение=	МетодКлиента("Модуль_Клиент", "ВыделитьСлово", ОригинальнаяСтрока, ";");
		
		СтрокаТаблицы=				ТабКлючиЗначения.Добавить();
		СтрокаТаблицы.Ключ=			СтрЗаменить(МетодКлиента("Модуль_Клиент", "ВыделитьСлово", КлючИЗначение, "="), "=", "");
		СтрокаТаблицы.Значение=		СтрЗаменить(МетодКлиента("Модуль_Клиент", "ВыделитьСлово", КлючИЗначение, ";"), ";", "");
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);

	ЗагрузитьСтрокуКлючЗначение(СтрокаКлючЗначение);
	
	Если ЗначениеЗаполнено(ПолучитьШаблонКлючейСервер()) Тогда
		ЭтаФорма.Элементы.ТабКлючиЗначенияВосстановитьШаблонПолей.Видимость = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	СтрокаКлючЗначение=	Параметры.СтрокаКлючЗначение;
	DocumentType=		Параметры.DocumentType;
	Организация=		Параметры.Организация;
	IDОрганизации=		Параметры.IDОрганизации;
	
КонецПроцедуры

