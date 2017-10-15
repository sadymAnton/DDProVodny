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

&НаКлиенте
Процедура ПроверитьПараметрыПодключения(Команда)
	
	Если НастройкиПодключенияВерны() тогда
 		ПоказатьПредупреждение(,"Подключение к серверу " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы + " прошло успешно!", 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
	Иначе 
		ПоказатьПредупреждение(,"Не удалось подключиться к серверу " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы + ".", 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьНастройкиПодключения(ObjectAPI) Экспорт
	
	Если ВариантИспользованияПроксиСервера = "ИспользоватьНастройкиIE" Тогда
		ObjectAPI.ProxyMode=	"UseDefaultProxy";
	ИначеЕсли ВариантИспользованияПроксиСервера = "ИспользоватьПроксиСервер" Тогда
		
		ObjectAPI.ProxyMode=	"UseProxy";
		
		ProxySettings=			ObjectAPI.ProxySettings;
		ProxySettings.URL=		АдресПроксиСервера + ?(ПустаяСтрока(ПортПроксиСервера), "", ":" + ПортПроксиСервера);
		ProxySettings.Login=	ЛогинПроксиСервера;
		ProxySettings.Password=	ПарольПроксиСервера;
		
	Иначе
		ObjectAPI.ProxyMode=	"NoProxy";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция НастройкиПодключенияВерны() Экспорт
	
	УстановитьНастройкиПодключения(Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPIДляТестированияПодключения);
		
	Возврат Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPIДляТестированияПодключения.TestConnection();

КонецФункции	

&НаКлиенте
Функция НастройкиПроксиСервера()
	
	СтруктураНастроекПрокси= Новый Структура("ВариантИспользования, Адрес, Логин, Пароль", ВариантИспользованияПроксиСервера);
	
	Если ВариантИспользованияПроксиСервера = "ИспользоватьПроксиСервер" Тогда
		
		СтруктураНастроекПрокси.Адрес=  АдресПроксиСервера + ?(ЗначениеЗаполнено(ПортПроксиСервера), ":" + ПортПроксиСервера, "");
		СтруктураНастроекПрокси.Логин=  ЛогинПроксиСервера;
		СтруктураНастроекПрокси.Пароль= ПарольПроксиСервера;
		
	КонецЕсли;
	
	Возврат СтруктураНастроекПрокси;
	
КонецФункции

&НаКлиенте
Процедура Ок(Команда)
	
	Если НЕ Модифицированность Тогда
		Закрыть();
		Возврат;
	КонецЕсли;
	
	Если НастройкиПодключенияВерны() <> Истина Тогда
		ПоказатьПредупреждение(,"Не удалось подключиться к серверу " + Платформа.ПараметрыКлиент.СловарьWL.КраткоеНаименованиеСистемыРодительныйПадеж + ".", 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
        Возврат;
	КонецЕсли;
	
	МетодСервераБезКонтекста(,"УстановитьНастройкиПрокси", НастройкиПроксиСервера());
	
	УстановитьНастройкиПодключения(Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPI);
	УстановитьНастройкиПодключения(Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPIДляТестированияПодключения);
	
	ПоказатьПредупреждение(Новый ОписаниеОповещения("ПерезапускМодуля", ЭтаФорма), 
	"Настройки прокси сервера обновлены!
	|  Модуль закрыт и открыт повторно.",
	120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
							
КонецПроцедуры

&НаКлиенте
Процедура ПерезапускМодуля(ДополнительныеПараметры) Экспорт
	
	ВладелецФормыИмяФормы= ВладелецФормы.ИмяФормы;
	
	ВладелецФормы.Закрыть();
	
	ОткрытьФорму(ВладелецФормыИмяФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Этаформа.Закрыть(Ложь);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	НастрокиПроксиСервера= МетодСервера(,"ПолучитьНастройкиПрокси");
	
	ВариантИспользованияПроксиСервера= НастрокиПроксиСервера.ВариантИспользования;
	
	ПозицияРазделителя= Найти(НастрокиПроксиСервера.Адрес, ":");
	Если ПозицияРазделителя > 0 тогда 
		ПортПроксиСервера=  Сред(НастрокиПроксиСервера.Адрес, ПозицияРазделителя + 1);
		АдресПроксиСервера= Лев(НастрокиПроксиСервера.Адрес , ПозицияРазделителя - 1);
	Иначе
		АдресПроксиСервера= НастрокиПроксиСервера.Адрес;
	КонецЕсли;	
 	
	ЛогинПроксиСервера=  НастрокиПроксиСервера.Логин;
	ПарольПроксиСервера= НастрокиПроксиСервера.Пароль;
	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеФормой()
	
	Элементы.АдресПроксиСервера.Доступность=  ВариантИспользованияПроксиСервера= "ИспользоватьПроксиСервер";
	Элементы.ПортПроксиСервера.Доступность=   Элементы.АдресПроксиСервера.Доступность;
	Элементы.ЛогинПроксиСервера.Доступность=  Элементы.АдресПроксиСервера.Доступность;
	Элементы.ПарольПроксиСервера.Доступность= Элементы.АдресПроксиСервера.Доступность;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);
	
	ЗаполнитьСписокВыбораВариантИспользованияПроксиСервера();
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСписокВыбораВариантИспользованияПроксиСервера()
	
	ВариантыИспользованияПроксиСервера= МетодКлиента("Модуль_Клиент","ВариантыИспользованияПроксиСервера");
	
	Для Каждого ЭлементСписка ИЗ ВариантыИспользованияПроксиСервера Цикл
		Элементы.ВариантИспользованияПроксиСервера.СписокВыбора.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВариантИспользованияПроксиСервераПриИзменении(Элемент)
	
	УправлениеФормой();
	
КонецПроцедуры

