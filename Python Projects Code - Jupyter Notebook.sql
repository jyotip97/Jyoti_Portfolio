--Black Jack Game

import random
#import clear()
#from art import logo

def deal_card():
    """Returns a random card from the deck."""
    cards = [11,2,3,4,5,6,7,8,9,10,10,10,10]
    card = random.choice(cards)
    return card

def calculate_score(cards):
    """Take a list of cards and return the score calculated from the cards"""
    if sum(cards) == 21 and len(cards) == 2:
        return 0
    if 11 in cards and sum(cards) > 21:
        cards.remove(11)
        cards.append(1)
    return sum(cards)


def compare(user_score, computer_score):
    if user_score == computer_score:
        return "It's a Draw."
    elif computer_score == 0:
        return "You lost, opponent has a BlackJack."
    elif user_score == 0:
        return "You Win, BlackJack."
    elif user_score > 21:
        return "You went over. You Lose."
    elif computer_score > 21:
        return "Opponent went over. You win"
    elif user_score > computer_score:
        return "You Win"
    else:
        return "You Lose"

def play_game():
    #print(logo)
    user_cards = []
    computer_cards = []
    is_game_over = False

    for _ in range(2):
        user_cards.append(deal_card())
        computer_cards.append(deal_card())

    while not is_game_over:
        user_score = calculate_score(user_cards)
        computer_score = calculate_score(computer_cards) 
        print(f"   Your cards: {user_cards}, Current score: {user_score}")
        print(f"   Computer's first card: {computer_cards[0]}")

        if user_score == 0 or computer_score == 0 or user_score > 21:
            is_game_over = True 
        else:
            user_should_deal = input("Type 'y' to get another card, type 'n' to pass: ")
            if user_should_deal == "y":
                user_cards.append(deal_card())
            else:
                is_game_over = True

    while computer_score != 0 and computer_score < 17:
        computer_cards.append(deal_card())
        computer_score = calculate_score(computer_cards)

    print(f"   Your final hand: {user_cards}, final score: {user_score}")
    print(f"   Computer's final hand: {computer_cards}, computer's final score: {computer_score}")
    print(compare(user_score, computer_score))

while input("Do you want to play BalckJack? Type 'y' or 'n': ") == "y":
    #clear()
    play_game()
    

--Calculator

operations = {
    "+": add,
    "-": subtract,
    "*": multiply,
    "/": divide
}
def calculator():
    num1 = int(input("What's the first number?: "))
    for symbol in operations:
        print(symbol)
    should_continue = True
    while should_continue:
        operation_symbol = input("Pick an operation: ")
        num2 = int(input("What's the next number?: "))
        calculation_function = operations[operation_symbol]
        answer = calculation_function(num1, num2)
        print(f"{num1} {operation_symbol} {num2} = {answer}")

        if input(f"Type 'y' to continue calculating with {answer}, or type 'n' to exit.: ") == "y":
            num1 = answer
        else:
            should_continue = False

calculator()


--BMI Calculator

height = float(input("enter your height in m: "))
weight = float(input("enter your weight in kg: "))

bmi = round(weight / height ** 2)

if bmi < 18.5:
    print(f"Your BMI is {bmi}, you are underweight.")
elif bmi < 25:
    print(f"Your BMI is {bmi}, you have a normal weight.")
elif bmi < 30:
    print(f"Your BMI is {bmi}, you are slightly overweight")
elif bmi < 35:
        print(f"Your BMI is {bmi}, you are obese.")
else:
    print("You are clinically obese.")


--Conditional Statement and Logical Operators

height = int(input("What's your height? "))
age = int(input("What's your age? "))
bill = 0

if height >=120:
    if age < 12:
        bill = 5
        print("Child tickets are $5.")
    elif age <=18:
        bill = 7
        print("Youth tickets are $7.")
    elif age >= 45 and age <= 55:
        print("Everything is gonna be okay. Have a free ride on us.")
    else:
        bill = 12
        print("Adult tickets are $12.")
        
    
    wants_photo = input("Do you want a photo taken? Y or N.")
    if wants_photo == "Y":
        bill += 3
        
        print(f"Your total would be bill {bill}")

else:
    print("Sorry, your height isn't matching the rollercoaster ride criteria.")