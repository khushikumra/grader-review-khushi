CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [ ! -e student-submission/ListExamples.java ]; then 
    echo "Error: ListExamples.java not found in the repository"
    exit 1
fi 

cp student-submission/ListExamples.java grading-area/

cd grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar ListExamples.java

if [ $? -ne 0 ]; then
    echo "Error: Compilation of ListExamples.java failed."
    exit 1
fi

cd ..
cp TestListExamples.java grading-area/
cd grading-area

cd ..
cp -R lib grading-area/
cd grading-area

#javac -cp ./:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar TestListExamples.java

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar TestListExamples.java

if [ $? -ne 0 ]; then
    echo "Error: Compilation of TestListExamples.java failed."
    exit 1
fi 

#java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples

if [ $? -eq 0 ]; then 
    echo "Congratulations. Tests Passed."
else 
    echo "Tests failed. Review the feedback above."
fi