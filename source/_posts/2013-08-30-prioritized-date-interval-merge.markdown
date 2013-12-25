---
layout: post
title: "Prioritized date interval merge"
date: 2013-08-30 23:57
comments: true
sharing: true
categories: Recursion, Python
---

Ran into this interesting problem lately and wanted to code up a recursive solution in Python. Essentially an extension of merge from merge sort but for intervals. There is definitely something very satisfying about coding up a recursive solution, as they tend to produce clean solutions despite the ugly formatting in this case to make list concatenation work.

``` python Merge date intervals by priority https://github.com/avidas/Code_snippets/blob/master/merge_interval.py Source
def merge_interval(low_priority_lst,high_priority_lst):
	'''
	Given two lists with sorted date ranges, return merged list with high_priority_lst 
	ranges preferred over low_priority_lst ranges in case of intersection.
	Partial intervals are allowed.
	'''
	if low_priority_lst == [] or low_priority_lst == None: return high_priority_lst
	if high_priority_lst == [] or high_priority_lst == None: return low_priority_lst
	
	# case :               |-------|
	#        |-------|            
	if low_priority_lst[0][0] > high_priority_lst[0][1]:
	 return [high_priority_lst[0]] + 
	 		merge_interval(low_priority_lst,high_priority_lst[1:])
	# case :   |-------|
	#                     |-------|  	 
	elif low_priority_lst[0][1] < high_priority_lst[0][0]:
		return [low_priority_lst[0]] + 
			merge_interval(low_priority_lst[1:],high_priority_lst)
	# case :|-------|
	#            |-------|  
	elif low_priority_lst[0][0] < high_priority_lst[0][0]:
		return [[low_priority_lst[0][0],high_priority_lst[0][0]]] + 
			merge_interval( [[high_priority_lst[0][0],low_priority_lst[0][1]]] +
								 low_priority_lst[1:], high_priority_lst)
	# case :      |-------|
	#        |-------|  
	elif low_priority_lst[0][1] > high_priority_lst[0][1]:
		return [high_priority_lst[0]] + 
			merge_interval( [[high_priority_lst[0][1],low_priority_lst[0][1]]] +
								low_priority_lst[1:] , high_priority_lst[1:])
	# case :  |-------| |---| |----|
	#        |-----------------| 
	else:
		return merge_interval(low_priority_lst[1:],high_priority_lst)
```

Complexity :

<!--more-->

Analyzing time complexity for this gets interesting. Consider low_priority_lst to be of length l and high_priority_lst to be of length h. In the worst case each h interval is a sub interval of each l interval. That would give us a result set with 2*l + h elements and the thus the complexity of the algorithm is O(l+h) in the worst case. 

Clearly this is not tail recursive, but as far as I know Python does not optimize for tail recursion. Something to think of is to extend it to lists 1...n, with priority p1 < p2 < .... pn, and which would give us a complexity of sum(si), 0< i < n-1 where si is the size of the ith interval. 

If the lists are unsorted, adapting this method as is would require the caller method to sort the lists beforehand. Sorting being nlogn, it would dominate the linear compexity for and the complexity would be sum(si*log(si)), 0< i < n-1 for the case with n intervals.