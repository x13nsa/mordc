#! /bin/sh
#                                     .-.	art by: cp97
#  ((_,...,_))   __ ___   ___  _ __ __| | ___ 	coded by: x13nsa
#     |o o|     '_ ` _ \ / _ \| '__/ _` |/ __|	date: Jul 15 2024 (happy birthday!!)
#     \   /     | | | | | (_) | | | (_| | (__ 
#      ^-^      | |_| |_|\___/|_|  \__,_|\___|


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

test_morse_to_text () {
  assertEquals "$(./mordc d ".... --- .-.. .- ")" "hola"
  assertEquals "$(./mordc d ".. / -.. .. -.. / -. --- - / -.- -. --- .-- ")" "i did not know"
  assertEquals "$(./mordc d "--- .... / -.. --- ...- . !!!")" "oh dove!!!"
  assertEquals "$(./mordc d "-..- 86 / .. ... / .- .-- . ... --- -- . ")" "x86 is awesome"
  assertEquals "$(./mordc d "--.- ..- .- -. -.. / - ..- / ... --- ..- .-. .. ... ")" "quand tu souris"
}

. /usr/bin/shunit2
