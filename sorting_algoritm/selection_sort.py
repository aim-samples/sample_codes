# selection sort using unpacking tuple
# find smaller number in remaining whole array and exchange it with element at starting position of remaining array

myList = [1, 4, 2, 100, 20, 7, 8, 5, 3, 70, 0]

# print(myList)
for i in range(len(myList) - 1) : 
    min_index = i

    for j in range(i + 1, len(myList)) :
        if myList[min_index] > myList[j] :
            min_index = j

    myList[min_index], myList[i] = myList[i], myList[min_index]
    print(myList)

# print(myList)
        
