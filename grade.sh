CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission

if [[ -e ListExamples.java ]]
then
    echo "File with correct name was submitted (ListExamples.java)"
else
    echo "File with incorrect name was submitted. Rename to ListExamples.java"
    exit
fi 

cd ../

cp student-submission/ListExamples.java ./
javac -cp $CPATH *.java 2> error-trace.txt

if [[ $? -ne 0 ]]
then
    echo "There was an error compling the file"
    cat error-trace.txt
    exit
else 
    echo "The java code was compiled successfully"
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test-output.txt

echo "--------"
last_line=$(tail -n 2 test-output.txt)
echo $last_line
echo "--------"
echo "Execution ended"

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples


