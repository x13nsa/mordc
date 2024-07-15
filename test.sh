#! /bin/sh
# file: examples/equality_test.sh

oneTimeSetUp () {
  if ! [ -f /usr/bin/shunit2 ]; then
    echo "error: shunit2 was not found"
    exit 0
   fi
   if ! [ -f mordc ]; then
     make
   fi
}

test_text_to_morse () {
  assertEquals "$(./mordc e "hola")" ".... --- .-.. .- "
  assertEquals "$(./mordc e "july")" ".--- ..- .-.. -.-- "
  assertEquals "$(./mordc e "far caspian")" "..-. .- .-. / -.-. .- ... .--. .. .- -. "
  assertEquals "$(./mordc e "1234567890")" "1 2 3 4 5 6 7 8 9 0 "
  assertEquals "$(./mordc e "between days")" "-... . - .-- . . -. / -.. .- -.-- ... "
}


. /usr/bin/shunit2
