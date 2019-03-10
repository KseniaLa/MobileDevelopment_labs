import React from 'react';
import { StyleSheet, Text, View, Image, ScrollView, Button } from 'react-native';
import IconBadge from 'react-native-icon-badge';
import { Icon } from 'react-native-elements';
import NumericInput from 'react-native-numeric-input';
import { Constants, SQLite } from 'expo';

const db = SQLite.openDatabase('shop.db');

export default class DetailsScreen extends React.Component {
  constructor(props) {
    super(props);
    const { navigation } = this.props;
    const itemId = navigation.getParam('id', 'NO-ID');
    this.state = { id: itemId, data: {}, count: 1 };
  }

  getItemData() {
    db.transaction(tx => {
      tx.executeSql(
        `select * from items where id = ?;`,
        [this.state.id],
        (_, { rows: { _array } }) => this.setState({ data: _array[0] })
      );
    });
  }

  componentDidMount() {
    this.getItemData();
  }

  static navigationOptions = ({ navigation }) => {
    const { params = {} } = navigation.state;
    return {
      headerStyle: {
        backgroundColor: '#1E91FF',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
          {!params.isCartItem &&
            <>
              <IconBadge
                MainElement={
                  <Icon
                    reverse
                    color='#0000FF'
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
                    top: 4,
                    right: 4,
                    width: 20,
                    height: 20,
                    fontWeight: 10,
                    backgroundColor: '#ff0000'
                  }
                }
                Hidden={5 === 0}
              />
              <Icon
                reverse
                color='#0000ff'
                name="cart-plus"
                type='font-awesome'
                size={21}
              // onPress={() => navigation.navigate('Cart')} 
              />
            </>
          }
        </View>
      ),
    };
  }

  render() {
    let item = this.state.data;
    return (

      <ScrollView>
        <View style={{ flex: 1, alignItems: "center" }}>
          <Image
            source={require('./../images/empty-image.png')}
            style={styles.image}
          />
          <NumericInput
            type='plus-minus'
            minValue={1}
            maxValue={item.count}
            onChange={value => this.setState({count: value})}
            rounded
            textColor='#B0228C'
            iconStyle={{ color: 'white' }}
            rightButtonBackgroundColor='#0000ff'
            leftButtonBackgroundColor='#0000ff'
            borderColor='#0000ff'
            initValue={1}
          />
          <Text>Model: {item.name}</Text>
          <Text>Description: {item.description}</Text>
          <Text>Price: {item.price}</Text>
          <Text>Available count: {item.count}</Text>
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