# bubble sort
# find smaller number in pair and move one place before

myList = [1, 4, 2, 100, 20, 7, 8, 5, 3, 70, 0]

for i in range(len(myList) - 1):
    for j in range(len(myList) - 1):
        if(myList[j] > myList[j+1]):
            temp = myList[j+1]
            myList[j+1] = myList[j]
            myList[j] = temp
print(myList)
