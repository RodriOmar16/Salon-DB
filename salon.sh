#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  if [[ -z $1 ]]
  then
    echo -e "Welcome to My Salon, how can I help you?\n"
  fi
  echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim\n6) exit"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) VALIDO ;;
    2) VALIDO ;;
    3) VALIDO ;;
    4) VALIDO ;;
    5) VALIDO ;;
    6) EXIT ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}
VALIDO(){
  #INPUT NUMBER
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #GET PHONE
  CUSTOMER_NUMBER=$($PSQL "select phone from customers where phone='$CUSTOMER_PHONE';")
  
  if [[ -z $CUSTOMER_NUMBER ]]
  then
    #GET NAME
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    #INSERT INTO CUSTOMERS
    INSERT_CUSTOM=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
    echo -e "\nInsert: $INSERT_CUSTOM"
  else
    #GET NAME
    CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE';")
  fi
  #GET TIME
  SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED;")
  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  #INSERT INTO APPOINTMENTS
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
  INSERT_APPOINT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME');")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}

EXIT() {
  echo -e "\nThank you.\n"
}
MAIN_MENU