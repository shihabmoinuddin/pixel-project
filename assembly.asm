# P1-2
# Student Name: Shihab Moinudidn	
# Date: 10/5/21

.data
Pile:  .alloc	1024

.text

Locate:	addi	$1, $0, Pile		# point to array base
#	addi    $2, $0, -1		# load in pile from file ** Debugging
#	addi    $3, $0, 4		# part color to locate ** Debugging
swi	598				# create pile and select color
.data
Pile:  .alloc	1024

.text

Locate:	addi	$1, $0, Pile		# point to array base					
					# $3 holds part color
#	addi    $2, $0, -1		# load in pile from file ** Debugging
#	addi    $3, $0, 4		# part color to locate ** Debuggingaddi    $2, $0, 2048			#starts from the middle and stops at first match
	swi     547			
	lb      $4, Pile($2)
	addi	$15, $0, 0
	addi 	$16, $0, 0
Loop:	addi    $2, $2, 1			#finding the first match		
	lb      $4, Pile($2)
	bne	$3, $4, Loop			#until there is a match, keep going row by row
	swi	547

Cup:	addi 	$2, $2, -64			#going up the vertical lines
	addi 	$5, $5, 1			#counter $5 to keep track of how many pixeles it goes up 
	swi 	547
	lb	$4, Pile($2)			
	beq	$3, $4, Cup			#if the pixel above is a match, keep looping
						#when we no longer have a match, automatically goes to jup
					
jup:	addi	$2, $2, -64			#skips one pixel per iteration in case of overlap going up
	swi 	547				#this chunk of code only runs when theres a mismatch 
	lb	$4, Pile($2)			#going up the vertical line
	bne 	$3, $4, reset
	j	Cup

reset:	addi 	$2, $2, 128			#resets so that you can go down the column now 
	add	$6, $0, $2			#save the max-y value (so far) into register $6 
	addi 	$7, $0, 64			#optimize ;)
	mult 	$5, $7
	mflo 	$8
	add	$2, $2, $8			#add offset to be one pixel past the original first find
	swi 	547

	
Cdown:	addi 	$2, $2, 64			#going down vertical line 
	swi 	547
	lb 	$4, Pile($2)			
	beq	$3, $4, Cdown			#if the next lower pixel is a match, keep going down and loop
		
jdown:	addi 	$2, $2, 64			#skips one pixel per interation in case of overlap going down
	swi 	547
	lb 	$4, Pile($2)			
	beq 	$3, $4, Cdown			#if after skipping one its a match again, we can keep 
						#going down the vertical line

	addi	$2, $2, -128			#now we're 2 pixels below our match, so we compensate
	add 	$7, $0, $2			#save the min-y value (so far) into register $7 
				
HS:	addi 	$2, $2, -64			#HS - Horizontal Search
	addi	$2, $2, -1			#goes up a pixel and searches its adjacent pixels until match
	lb 	$4, Pile($2)
	swi	547
	beq	$3, $4, left			#branches to left if pixel on left is match
	addi 	$2, $2, 2
	lb	$4, Pile($2)
	swi 	547
	beq 	$3, $4, right			#branches to right if pixel on right is match
	addi 	$2, $2, -1
	j	HS

left:	addi	$2, $2, 1			#offset so the counter value is right
l:	swi 	547				#if match is found, continue going left  
	addi 	$2, $2, -1
	lb	$4, Pile($2)
	bne	$3, $4, stopl
	addi	$8, $2, 1			#increment counter so ik how many spots to add to get to same position
	j	l

stopl:	addi 	$2, $2, -1			#increment one more in case of overlap
	swi 	547
	lb 	$4, Pile($2)
	beq	$3, $4, l			#if after skipping, we have a match, keep looping l
	addi	$9, $2, 2			#otherwise save the min-x value (so far) into register $9
	j	r				#save with offset of 2 since we are now 2 left of our min-x value
				
right:	addi 	$2, $2, -1			#offset so the counter value is right
r:	swi 	547						
	addi 	$2, $2, 1			#go right
	lb	$4, Pile($2)
	bne	$3, $4, stopr
	j 	r

stopr:	addi 	$2, $2, 1			#increment one more in case of overlap
	swi 	547
	lb	$4, Pile($2)
	beq	$3, $4, r			#if after skipping, we have match, keep looping r
	addi 	$10, $2, -2			#otherwise save the max-x value (so far) into register $10
	lui  $2, 520
	ori  $2, $2, 720	
	swi	599				# submit answer and check
	jr	$31				# return to caller
		

