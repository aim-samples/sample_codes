inNum = int(input('input number:'))

fact = 1
for i in range(1, inNum+1):
    fact *= i

print('factorial on {0} is {1}'.format(inNum, fact))