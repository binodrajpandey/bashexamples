echo write a program to check whether a entered number is prime number or not.
echo Enter a Number
read a
counter=1
test=0
while [ $counter -le $a ]
do
	#rem =(($a % $counter))
	#echo $rem
	if (($a % $counter == 0 ))
	then
		((test++))
		fi
		((counter++))
		done
		
if [ $test == 2 ]
	then 
	echo $a is prime number
	
	else 
	echo $a is not prime number $test
	
	fi