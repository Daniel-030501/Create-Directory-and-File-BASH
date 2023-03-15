#!/bin/bash

#Script hanya dapat dijalankan oleh user Non-Root
if [[ ! $EUID -ne 0 ]]; then
   echo "This script must be run as Non-root" 1>&2
   exit 1
fi

function random_text() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $num_chars | head -n 1
}

#Function buat file dan direktori dengan devault value
function create_files_and_directories() {

if [ ! -f $PWD/.env  ]
then
    echo "File does not exist in Bash"
    echo "Create File..."
cat << EOF > .env
jumlah_file= 8
jumlah_dir= 4
jumlah_char= 64
jumlah_line= 32
EOF
fi
    echo "File Exist in Bash"
    local count_files=$(cat .env | awk '/jumlah_file/ {print $2}' .env)
    local count_dirs=$(cat .env | awk '/jumlah_dir/ {print $2}' .env)
    local num_lines=$(cat .env | awk '/jumlah_line/ {print $2}' .env)
    local num_chars=$(cat .env | awk '/jumlah_char/ {print $2}' .env)

#Buat Direktori
for (( i=1; i<=$count_dirs; i++ )) do
          
          dir_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
          mkdir -p output/$dir_name
          
    #Buat File
    for (( j=1; j<=$count_files; j++ )) do
          file_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
          file_path=output/$dir_name/$file_name 
          echo "`date` Create File dan Direktori success" >> /home/daniel/test/test4/script.log

        #Buat isi File
        for (( k=1; k<=$num_lines; k++ )) do
          echo $(random_text) >> $file_path
          echo "`date` Create isi File success" >> /home/daniel/test/test4/script.log
        done
    done
done
}

function create_files_and_directories2() {
cat << EOF > .env
jumlah_file= $count_files
jumlah_dir= $count_dirs
jumlah_char= $num_chars
jumlah_line= $num_lines
EOF

#Buat Direktori
for (( i=1; i<=$count_dirs; i++ )) do
          
          dir_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
          mkdir -p output/$dir_name
          
    #Buat File
    for (( j=1; j<=$count_files; j++ )) do
          file_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
          file_path=output/$dir_name/$file_name 
          echo "`date` Create File dan Direktori success" >> /home/daniel/test/test4/script.log

        #Buat isi File
        for (( k=1; k<=$num_lines; k++ )) do
          echo $(random_text) >> $file_path
          echo "`date` Create isi File success" >> /home/daniel/test/test4/script.log
        done
    done
done
}

while getopts ":f:d:l:c:s:" opt; do
    case ${opt} in
    f )
      count_files=${OPTARG}
      ;;
    d )
      count_dirs=${OPTARG}
      ;;
    l )
      num_lines=${OPTARG}
      ;;
    c )
      num_chars=${OPTARG}
      ;;
    s )
      word=${OPTARG} 
      ;;
    * )
      echo 'error' >&2
      exit 1
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done 

if [ $word ]; then
printf 'Searching for "%s"\n' "$word"
time $PWD | grep -inr $word ./
exit 1;
fi

if ( [ $count_files ] && [ $count_dirs ] && [ $num_lines ] && [ $num_chars ] && [ -z $word ] ); then
create_files_and_directories2 $count_files $count_dirs $num_lines $num_chars
echo "Input Success"
exit 1;
fi

#Jalankan Script tanpa input dari user
if ( [ -z $count_files ] || [ -z $count_dirs ] || [ -z $num_lines ] || [ -z $num_chars ] || [ -z $word ] ); then
create_files_and_directories  
echo "Success"
exit 1;
fi
