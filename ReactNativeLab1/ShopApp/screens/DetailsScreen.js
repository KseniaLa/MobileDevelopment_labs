import React from 'react';
import { StyleSheet, Text, View, Image, ScrollView, Button } from 'react-native';
import IconBadge from 'react-native-icon-badge';
import { Icon } from 'react-native-elements';
import NumericInput from 'react-native-numeric-input';
import appData from './../data';

export default class DetailsScreen extends React.Component {
  static navigationOptions = ({ navigation }) => {
    const { params = {} } = navigation.state;
    return {
      headerStyle: {
        backgroundColor: '#f4511e',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
          <IconBadge
            MainElement={
              <Icon
                reverse
                color='#517fa4'
                name="shopping-cart"
                type='font-awesome'
                size={21}
                onPress={() => navigation.navigate('Cart')}
              />
            }
            BadgeElement={
              <Text style={{ color: '#FFFFFF' }}>{5}</Text>
            }
            IconBadgeStyle={
              {
                top:4,
                right:4,
                width: 20,
                height: 20,
                fontWeight: 10,
                backgroundColor: '#FF00EE'
              }
            }
            Hidden={5 === 0}
          />
          <Icon
                reverse
                color='#517fa4'
                name="cart-plus"
                type='font-awesome'
                size={21}
                // onPress={() => navigation.navigate('Cart')} 
              />

        </View>
      ),
    };
  }

  render() {
    const { navigation } = this.props;
    const itemId = navigation.getParam('id', 'NO-ID');
    return(
      
      <ScrollView>
        <View style={{ flex: 1, alignItems: "center" }}>
      <Image
            source={require('./../images/empty-image.png')}
            style={styles.image}
          />
          <NumericInput 
          type='plus-minus' 
          minValue={1} 
          maxValue={appData[itemId].count} 
          onChange={value => console.log(value)}
          rounded 
            textColor='#B0228C' 
            iconStyle={{ color: 'white' }} 
            rightButtonBackgroundColor='#0000ff' 
            leftButtonBackgroundColor='#0000ff'
            borderColor='#0000ff'
            initValue={1}
          />
        <Text>Model: {appData[itemId].name}</Text>
        <Text>Description: {appData[itemId].description}</Text>
        <Text>Price: {appData[itemId].price}</Text>
        <Text>Available count: {appData[itemId].count}</Text>
        </View>
      </ScrollView>
      
      
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffa',
    alignItems: 'center',
    justifyContent: 'center',
  },
  rowContainer: {
    flexDirection: 'row',
    margin: 1,
    justifyContent: "center"
  },
  item: {
    flex: 1,
    height: 160,
    margin: 1
  },
  list: {
    flex: 1
  },
  image: {
    width: '80%',
    margin: 5,
    height: 250
  },
  button: {
    height: 30
  }
});