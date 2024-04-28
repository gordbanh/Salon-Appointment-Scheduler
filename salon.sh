#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c "

echo -e "\n~~ Welcome to Gordon's Relaxation Salon! ~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "Which service would you like?"
  echo -e "\n1) Manicure\n2) Pedicure\n3) Massage"

  #get service id
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in 
    1) MANICURE_MENU ;;
    2) PEDICURE_MENU ;;
    3) MASSAGE_MENU ;;
    *) MAIN_MENU "Please enter in a valid option" ;;
  esac

}

MANICURE_MENU() {
  #get service name from services table
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/^ *| *$//g')
  
  #get customer phone number from customers table
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE

  #get customer name from phone
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  #if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    #get customer name
    echo -e "\nWe didn't find your name in the system. What is your name?"
    read CUSTOMER_NAME
    #insert customer into customers table
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi

  #format customer name
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -e 's/^ *| *$//g')

  #get customer id from phone
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  #enter time
  echo -e "\nWhen would you like to schedule your appointment?"
  read SERVICE_TIME
  SERVICE_TIME_FORMATTED=$(echo $SERVICE_TIME | sed 's/^ *| *$//g')


  #insert appointment into appointments table
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME_FORMATTED, $CUSTOMER_NAME_FORMATTED."
}

PEDICURE_MENU() {
  #Duplicate of MANICURE_MENU

  #get service name from services table
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/^ *| *$//g')
  
  #get customer phone number from customers table
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE

  #get customer name from phone
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  #if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    #get customer name
    echo -e "\nWe didn't find your name in the system. What is your name?"
    read CUSTOMER_NAME
    #insert customer into customers table
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi

  #format customer name
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -e 's/^ *| *$//g')

  #get customer id from phone
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  #enter time
  echo -e "\nWhen would you like to schedule your appointment?"
  read SERVICE_TIME
  SERVICE_TIME_FORMATTED=$(echo $SERVICE_TIME | sed 's/^ *| *$//g')


  #insert appointment into appointments table
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME_FORMATTED, $CUSTOMER_NAME_FORMATTED."
}

MASSAGE_MENU() {
  #Duplicate of MANICURE_MENU

  #get service name from services table
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/^ *| *$//g')
  
  #get customer phone number from customers table
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE

  #get customer name from phone
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  #if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    #get customer name
    echo -e "\nWe didn't find your name in the system. What is your name?"
    read CUSTOMER_NAME
    #insert customer into customers table
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi

  #format customer name
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -e 's/^ *| *$//g')

  #get customer id from phone
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  #enter time
  echo -e "\nWhen would you like to schedule your appointment?"
  read SERVICE_TIME
  SERVICE_TIME_FORMATTED=$(echo $SERVICE_TIME | sed 's/^ *| *$//g')


  #insert appointment into appointments table
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME_FORMATTED, $CUSTOMER_NAME_FORMATTED."
}
MAIN_MENU