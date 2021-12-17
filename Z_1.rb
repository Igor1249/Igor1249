#  Program in Ruby
class Logistics #создание класса логистика

def initialize()
end

def data_input_consol() #ввод с консоли
    #1.Вводим в консоли параметры перевозимого груза - вес(кг), длина(см), ширина(см), высота(см)
    print "Вес груза (кг)  "
    @weight=gets.to_f  #вес груза
    print "Длина груза (см)  "
    @length= gets.to_f #длина груза в см
    print "Ширина груза (см)  "
    @width=gets.to_f #ширина груза в см
    print "Высота груза (см)  "
    @height=gets.to_f #высота груза в см

    # 2.Вводим в консоли название пункта отправления и название пункта назначения
    print "Пункт отправления  "
    @pointA=gets.to_s

    print "Пункт назачения  "
    @pointB=gets.to_s

end

def data_input(weight_test,length_test,width_test,height_test,point_of_departure,destination) #для тестов
    #1.Вводим параметры перевозимого груза - вес(кг), длина(см), ширина(см), высота(см)

    @weight=weight_test  #вес груза
    puts "Вес груза %f кг" %@weight

    @length= length_test #длина груза в см
    puts "Длина груза  %f см" %@length

    @width=width_test #ширина груза в см
    puts "Ширина груза  %f см" %@width

    @height=height_test#высота груза в см
    puts "Высота груза  %f см" %@height

    # 2.Вводим название пункта отправления и название пункта назначения
    @pointA = point_of_departure
    puts "Пункт отправления %s " %@pointA

    @pointB = destination
    puts "Пункт отправления %s " %@pointB
end

def pricer
    puts "----------------------"
    #  3. Через distancematrix.ai или любой другой сервис со схожим функционалом мы расчитываем расстояние,   которое груз должен преодолеть

    require "httparty"
    require 'net/http'
    url ="https://api.distancematrix.ai/maps/api/distancematrix/json?origins=#{@pointA}&destinations=#{@pointB}&departure_time=now&key=mWOtMjKiekl3Gt7EZqlZkG5GaFwwY"
    response = HTTParty.get(url)
    #puts response
    distance = response.parsed_response["rows"].first["elements"].first["distance"]["text"]
    puts distance.split(" ")[0] #преобразование в цифры
    puts  "Дистанция  = %f" % distance.to_f

    # 4.Результатом работы класса должен быть хеш следующего вида -> {weight: 1,length: 1, width: 1, height: 1, distance: 1, price: 1}
    # 5. Расчет цены:
    puts "Обьем груза  = %f м куб" % (@length*@width*@height/1000000)
    if @length*@width*@height <= 1000000 # Если груз <= 1 м. куб., то цена = 1 руб за км,
        price = 1*distance.to_f
        elsif  @weight < 10 # Если груз > 1 м. куб., но его вес < 10 кг, то цена  = 2 руб за км
          price = 2*distance.to_f
            else # Если груз > 1 м. куб. и его вес >= 10кг, то цена = 3 рубля за км
                price = 3*distance.to_f
end

    #вывод
    puts "----------------------"
    puts "Стоимость = "+ price.to_s
    puts "--------------------------------------------------------"
  end

end

#Ввод данных через консоль
#puts "Ввод данных через консоль"
#c = Logistics.new()
#c.data_input_consol()
#c.pricer

#Тест №1
puts "Тест №1"
c = Logistics.new()
c.data_input(1,100,100,100,"51.4822656,-0.1933769","51.4994794,-0.1269979")
c.pricer

#Тест №2
#puts "Тест №2"
#c = Logistics.new()
#c.data_input(5,111,222,333,"1677, Easton Rd, Willow Grove, PA 19090, USA","119 S Easton Rd, Glenside, PA 19038, USA")
#c.pricer

#Тест №3
#puts "Тест №3"
#c = Logistics.new()
#c.data_input(11,333,444,555,"Westminster Abbey, 20 Deans Yd, Westminster, London SW1P 3PA, United Kingdom","St John's Church, North End Rd, Fulham, London SW6 1PB, United Kingdom")
#c.pricer
