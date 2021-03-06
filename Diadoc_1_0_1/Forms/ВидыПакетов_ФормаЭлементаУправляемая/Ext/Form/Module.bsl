﻿&НаСервере
Перем ОбработкаОбъект;

&НаСервере
Функция ОбработкаОбъект()
	Если ОбработкаОбъект=Неопределено Тогда
		ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	КонецЕсли;
	Возврат ОбработкаОбъект;
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	СсылкаНаЭлемент = Параметры.Ссылка;
	
	Если ЗначениеЗаполнено(СсылкаНаЭлемент) Тогда
		
		ЗаполнитьРеквизитыФормыНаСервере();
	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРеквизитыФормыНаСервере()
	
	СтруктураРеквизитов = ОбработкаОбъект().ЭДО_СправочникМенеджер_ПолучитьЭлемент("ВидыПакетов",СсылкаНаЭлемент);
	
	Наименование	= СтруктураРеквизитов.Наименование;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьЭлементСправочника()
	
	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("Наименование",				Наименование);
	
	ОбработкаОбъект().ЭДО_СправочникМенеджер_СохранитьЭлемент("ВидыПакетов", СсылкаНаЭлемент, СтруктураРеквизитов);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьЭлементСправочника();	
	
	Оповестить("Диадок_Сохранение_ПакетДокументов");
	
	ЭтаФорма.Закрыть();
	
КонецПроцедуры
