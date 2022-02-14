mNum = input('Enter a number to check if a prime number: ')

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

try :
    mNum = int(mNum)
    if isPrime(mNum) :
        print("{} is a prime number".format(mNum))
    else:
        print(mNum, 'is not a prime number')
except ValueError:
    exit("error in value");
