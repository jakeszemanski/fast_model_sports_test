# Must handle denominations 20, 10, 5, 2, and 1
# Must be able to represent available moneys as a string
# Must be able to add money to register
# Must be able to take money from register
# Must be able to dispense change for dollar amounts







class Register
  def initialize
    @register = { 20 => 0, 10 => 0, 5 => 0, 2 => 0, 1 => 0 }
  end

  def total
    total = 0
    @register.each_pair do |bill_amount, quantity|
      puts "#{bill_amount} => #{quantity}"
      total += bill_amount * quantity
    end
    return total
  end

  def add_money(new_money)
    twenties_recieved = new_money / 20
    @register[20] += twenties_recieved
    leftover20 = new_money % 20

    tens_recieved = leftover20 / 10
    @register[10] += tens_recieved
    leftover10 = leftover20 % 10

    fives_recieved = leftover10 / 5
    @register[5] += fives_recieved
    leftover5 = leftover10 % 5

    twos_recieved = leftover5 / 2
    @register[2] += twos_recieved
    leftover2 = leftover5 % 2

    ones_recieved = leftover2 / 1
    @register[1] += ones_recieved
  end

  def take_money(money_requested)
    change = []
    twenties_requested = money_requested / 20 
    if @register[20] >= twenties_requested
      twenties_requested.times do
        change << 20
      end
      outstanding20 = 0
      new_register20 = @register[20] - twenties_requested
    else
      @register[20].times do
        change << 20
      end
      outstanding20 = @register[20] - twenties_requested
      new_register20 = 0
    end
    
    outstanding20 = outstanding20.abs * 20
    leftover20 = money_requested % 20
    leftover20 = leftover20 + outstanding20
    
    tens_requested = leftover20 / 10
      if @register[10] >= tens_requested
        tens_requested.times do
          change << 10
        end
        outstanding10 = 0
        new_register10 = @register[10] - tens_requested
      else
        @register[10].times do
          change << 10
        end
        outstanding10 = @register[10] - tens_requested
        new_register10 = 0
    end

    outstanding10 = outstanding10.abs * 10
    leftover10 = leftover20 % 10
    leftover10 = leftover10 + outstanding10
    
    fives_requested = leftover10 / 5
      if @register[5] >= fives_requested
        fives_requested.times do
          change << 5
        end
        outstanding5 = 0
        new_register5 = @register[5] - fives_requested
      else
        @register[5].times do
          change << 5
        end
        outstanding5 = @register[5] - fives_requested
        new_register5 = 0
    end

    outstanding5 = outstanding5.abs * 5
    leftover5 = leftover10 % 5
    leftover5 = leftover5 + outstanding5
    
    twos_requested = leftover5 / 2
      if @register[2] >= twos_requested
        twos_requested.times do
          change << 2
        end
        outstanding2 = 0
        new_register2 = @register[2] - twos_requested
      else
        @register[2].times do
          change << 2
        end
        outstanding2 = @register[2] - twos_requested
        new_register2 = 0
    end

    outstanding2 = outstanding2.abs * 2
    leftover2 = leftover5 % 2
    leftover2 = leftover2 + outstanding2
    
    ones_requested = leftover2 / 1
      if @register[1] >= ones_requested
        ones_requested.times do
          change << 1
        end
        outstanding1 = 0
        new_register1 = @register[1] - ones_requested
      else
        @register[1].times do
          change << 1
        end
        outstanding1 = @register[1] - ones_requested
        new_register1 = 0
    end
    
    outstanding1 = outstanding1.abs * 1

    if outstanding1 > 0
      puts 'sorry, there is not enough money in the register for that transaction'
    else
      @register[20] = new_register20
      @register[10] = new_register10
      @register[5] = new_register5
      @register[2] = new_register2
      @register[1] = new_register1
    end
  end

end

register = Register.new
puts register.total

2.times do
  register.add_money(20)
end

4.times do
  register.add_money(10)
end

6.times do
  register.add_money(5)
end

4.times do
  register.add_money(2)
end

10.times do
  register.add_money(1)
end
puts register.total

register.take_money(20)

4.times do
  register.take_money(10)
end

3.times do
  register.take_money(5)
end

10.times do
  register.take_money(1)
end
puts register.total

register.take_money(11)
puts register.total

# Add 2 $20 bills, 4 $10 bills, 6 $5 bills, 4 $2 bills, 10 $1 bills to an empty register so that it ends up with a value of $128 total
# Take 1 $20, 4 $10 bills, 3 $5 bills and 10 $1 bills from the register leaving it with $43 total
# Make change for $11 with what is now in the register.  This should succeed, leaving $32 total
# Make change for $14.  This should fail.