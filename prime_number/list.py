mNum = input('Enter a number to find prime numbers between: ')
try :
    mNum = int(mNum)
except ValueError:
    exit("error in value");

myArray = range(mNum + 1)
primeNumbers = []

def isPrime(num) :
    notPrime = False
    if num > 1 :
        for j in range(2, num) :
            if num % j == 0 :
                notPrime = True
                break
    else : 
        notPrime = True
    if not notPrime :
        return True

for i in myArray :
    if isPrime(i) :
        primeNumbers.append(i)

print(primeNumbers)