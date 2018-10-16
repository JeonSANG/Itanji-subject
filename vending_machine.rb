#Itanji subject

class VendingMachine
  #自動販売機のInitialization
  def initialize(product0, product1, product2)
    @products  = [product0, product1, product2]   #ジュースのarray
    @sum       = 0                                #投入金額の総計
    @totalSale = 0                                #売り上げ金額
  end

  #情報の出力
  def prtInfo
    puts
    puts "**************************************************************"
    puts "*                     ジュースのリストを出力"
    puts "**************************************************************"

    #productsのジュースの名前, 価格, 数を出力します。
    for i in 0..@products.size-1
      print "*    #{i}. "
      print @products[i].getName
      print " : "

      print @products[i].getPrice
      print "円 "

      #ジュースが１つ以上場合、ジュースの数を出力します。
      if @products[i].getNumber.to_i > 0
        print @products[i].getNumber
        print "つ"
      #ジュースの数が０である場合、購入不可を出力します。
      else
        print "購入不可"
      end
      puts
    end

    #投入金額と売り上げ金額を出力します。
    puts "*"
    puts "*   投入金額 : #{@sum},     売り上げ金額 : #{@totalSale}"
    puts "**************************************************************"
  end

  #ユーザーが使う機能を選択
  def userChoice
    puts "*       1．お金の投入      2．払い戻し        3．購入"
    puts "**************************************************************"

    choice = gets.chomp                             #ユーザーの入力を受けます。

    if choice == '1'
      insertMoney
    elsif choice == '2'
      payback
    elsif choice == '3'
      purchase
    else
      puts "1,2,3の中で選択してください。"
    end
  end

  #お金の投入
  def insertMoney
    while true
      puts
      puts "**************************************************************"
      puts "*                       お金の投入"
      puts "**************************************************************"
      puts "*       10円、50円、100円、500円、1000円だけもらえます。"
      puts "*                 (数字だけ入力してください。)"
      puts "*"
      puts "*           投入金額 : #{@sum},   投入完了： -1 "
      puts "**************************************************************"

      choice = gets.chomp

      # 10, 50, 100, 500, 1000円の場合、適用します。
      if choice == '10' or choice == '50' or choice == '100' or choice == '500' or choice == '1000'
        @sum += choice.to_i

      # -1を入力する場合、戻ります。
      elsif choice == '-1'
        prtInfo
        userChoice
        break

      #設定しないお金は払い戻します。
      else
        puts "10, 50, 100, 500, 1000円をもらえます。"
        puts choice + "円を払い戻し"
      end
    end
  end

  #投入金額を全部払い戻します。
  def payback
    puts "**************************************************************"
    puts "                          #{@sum}円を払い戻し"
    puts "**************************************************************"

    @sum = 0
    prtInfo
    userChoice
  end

  #購入：数が0でないジュースと価格が投入金額の以下のジュースを購入できます。
  def purchase
    while true
      prtInfo

      puts "*          購入するジュースの番号を入力してください。"
      puts "*              ( -1を入力する場合、終了します。)"
      puts "**************************************************************"

      choice = gets.chomp

      #購入終了
      if choice == '-1'
        payback

      #間違った番号を入力する場合、何もしません。
      elsif choice.to_i < 0 or choice.to_i >= @products.size

      #購入
      else
        #投入金額＜購入するジュースの価格or購入するジュースの数が０である場合、何もしません。
        if @sum < @products[choice.to_i].getPrice or @products[choice.to_i].getNumber == 0
        else
          @sum -= @products[choice.to_i].getPrice
          @totalSale += @products[choice.to_i].getPrice
          @products[choice.to_i].setNumber(@products[choice.to_i].getNumber-1)
        end
        prtInfo
      end
    end
  end
end

#ジュースのclass
class Product
  def initialize(name, price, number)
    @name   = name                      #ジュースの名前
    @price  = price                     #ジュースの価格
    @number = number                    #ジュースの数
  end

  def setName(name)
    @name = name
  end

  def setPrice(price)
    @price = price
  end

  def setNumber(number)
    @number = number
  end

  def getName
    @name
  end

  def getPrice
    @price
  end

  def getNumber
    @number
  end
end

#ジュースのobjectを作ります。
cola    = Product.new("Cola",120,5)
redBull = Product.new("RedBull",200,5)
water   = Product.new("Water",100,5)

#自動販売機のobjectを作ります。
machine = VendingMachine.new(cola,redBull,water)

machine.prtInfo
machine.userChoice