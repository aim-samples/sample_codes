# array should be compulsary sorted to used binary search algorithm
# https://www.geeksforgeeks.org/binary-search/
myList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
myNum = 11


def binarySearch(left, right):
    if right >= left:
        middleIndex = (right + left) // 2
        if myNum == myList[middleIndex]:
            return middleIndex
        elif myNum > myList[middleIndex]:
            return binarySearch(middleIndex + 1, right)
        else:
            return binarySearch(left, middleIndex - 1)
    else:
        return -1

index = binarySearch(0, len(myList) - 1)
print(index)
