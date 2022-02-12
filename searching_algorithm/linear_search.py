myList = [1,5,2,8,7,3,4,9,0]
print(myList)
myNum = int(input('enter any number from array to find its position:'))
index = 0
for i in range(len(myList)) :
    if myList[i] == myNum :
        index = i
        break
else :
    index = -1

print(index)
