# array should be compulsary sorted to used binary search algorithm
# https://www.geeksforgeeks.org/binary-search/
myList = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
myNum = 18


def binarySearch(left, right):
    if right >= left:  # element may be present
        middleIndex = left + (right-1) // 2
        if myNum == myList[middleIndex] :
            return middleIndex
        elif myList[middleIndex] > myNum :
            return binarySearch(left, middleIndex - 1)
        else:
            return binarySearch(middleIndex+1, right)
    else:  # empty array element not present
        return -1

index = binarySearch(0, len(myList) - 1)
print(index)