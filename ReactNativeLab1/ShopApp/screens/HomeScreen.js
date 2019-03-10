import React from 'react';
import { StyleSheet, Text, View, Button, FlatList, TouchableOpacity, Image } from 'react-native';
import { SearchBar, Icon } from 'react-native-elements';
import IconBadge from 'react-native-icon-badge';
import Grid from 'react-native-grid-component';
import appData from './../data';
import { Constants, SQLite } from 'expo';
import images from './../imageContainer';

const db = SQLite.openDatabase('shop.db');

export default class HomeScreen extends React.Component {
  constructor(props) {
    super(props);
    this.state = { cartCount: 5, isTabs: false, data: [] };
    this.props.navigation.addListener(
      'willFocus',
      _ => {
        this.update();
        this.updateCartCount();
      }
    )
  }

  update() {
    db.transaction(tx => {
      tx.executeSql(
        `select * from items;`,
        [],
        (_, { rows: { _array } }) => this.setState({ data: _array })
      );
    });
  }

  updateCartCount() {
    db.transaction(tx => {
      tx.executeSql(
        `select count(*) as cnt from cart;`,
        [],
        (_, { rows: { _array } }) => this.props.navigation.setParams({cartCount: _array[0].cnt}),
        (_, res) =>  this.props.navigation.setParams({cartCount: 0}) 
      );
    });
  }

  componentDidMount() {
    db.transaction(tx => {
      tx.executeSql(
        'create table if not exists items (id integer primary key not null, name text, description text, image text, price integer, count integer);',  [], (_) =>
        console.log('items ok')
      );
      tx.executeSql(
        'create table if not exists cart (id integer primary key not null, item_id integer, count integer, constraint fk_items foreign key (item_id) references items (id), CONSTRAINT item_unique UNIQUE (item_id));',  [], (_) =>
        console.log('cart ok')
      );
      //tx.executeSql('drop table items', []);
      //tx.executeSql('delete from items where id = 3', [], null, (_, res) => console.log(res));
      // tx.executeSql('select * from items', [], (_, { rows }) =>
      //     console.log(JSON.stringify(rows))
      //   );

      for (let i = 0; i < appData.length; i++){
        tx.executeSql('insert into items (id, name, description, image, price, count) values (?, ?, ?, ?, ?, ?)', [appData[i].id, appData[i].name, appData[i].description, appData[i].image, appData[i].price, appData[i].count]);
      }

      // tx.executeSql('insert into items (id, name, description, image, price, count) values (1, ?, ?, ?, 300, 30)', ['item2', 'new item', 'default']);
      //   tx.executeSql('select * from items', [], (_, { rows }) =>
      //     console.log(JSON.stringify(rows))
      //   );
    });

    this.update();

    this.props.navigation.setParams({
      //cartCount: this.state.cartCount,
      toggleListView: this.toggleListAppearance.bind(this),
      listView: this.state.isTabs
    });
  }

  toggleListAppearance() {
    let isTabsVal = this.state.isTabs;
    this.setState({ isTabs: !isTabsVal });
    this.props.navigation.setParams({
      listView: !isTabsVal,
    });
  }

  static navigationOptions = ({ navigation }) => {
    const { params = {} } = navigation.state;
    return {
      headerTitle: "Catalog",
      headerStyle: {
        backgroundColor: '#1E91FF',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
          <Icon
            reverse
            color='#0000ff'
            name={params.listView ? "view-list" : "dashboard"}
            type='material'
            size={21}
            onPress={() => params.toggleListView()}
          />

          <IconBadge
            MainElement={
              <Icon
                reverse
                color='#0000ff'
                name="shopping-cart"
                type='font-awesome'
                size={21}
                onPress={() => navigation.navigate('Cart')}
              />
            }
            BadgeElement={
              <Text style={{ color: '#FFFFFF' }}>{params.cartCount}</Text>
            }
            IconBadgeStyle={
              {
                top: 4,
                right:4,
                width: 20,
                height: 20,
                backgroundColor: '#FF0000'
              }
            }
            Hidden={params.cartCount === 0}
          />


        </View>
      ),
    };
  }

  _keyExtractor = (item) => `${item.id}`;

  renderListItem = ({ item }) => (
    <ListItem
      id={item.id}
      onPressItem={this._onPressItem}
      name={item.name}
      description={item.description}
      price={item.price}
      count={item.count}
      image={item.image}
    />
  );

  renderGridItem = (item) => (
    <GridItem
      id={item.id}
      key={item.id}
      onPressItem={this._onPressItem}
      item={item}
    />
  );

  _onPressItem = (itemId) => {
    const { navigate } = this.props.navigation;
    navigate('Details', { id: itemId, isCartItem: false })
  };

  //renderPlaceholder = item => <View style={styles.gridItem} key={item.id} />;

  render() {
    let isTabs = this.state.isTabs;
    let itemList;
    if (isTabs) {
      itemList = <Grid
        style={styles.list}
        renderItem={this.renderGridItem}
        //renderPlaceholder={this.renderPlaceholder}
        data={this.state.data}
        itemsPerRow={3}
      />
    }
    else {
      itemList = <FlatList
        data={this.state.data}
        style={{backgroundColor: "#dcdcdc"}}
        keyExtractor={this._keyExtractor}
        renderItem={this.renderListItem}
      />
    }
    return (
      <>{itemList}</>
    );
  }
}

class ListItem extends React.PureComponent {
  _onPress = () => {
    this.props.onPressItem(this.props.id);
  }

  render() {
    const img = this.props.image;
    return (
      <TouchableOpacity onPress={this._onPress} key={this.props.id}>
        <View style={styles.listItem} >
          <Image
            source={this.props.image ? images[this.props.image] : require('./../images/empty-image.png')}
            style={{ width: 100, height: 100, margin: 5 }}
            resizeMode="contain"
          />
          <View style={styles.listItemInfo}><Text numberOfLines={1} style={styles.listName}>{this.props.name}</Text>
            <Text numberOfLines={3} style={styles.listDescription}>{this.props.description}</Text>
            <Text style={styles.price}>{this.props.price} $</Text>
            <Text style={[{backgroundColor: this.props.count == 0 ? "#ff0000" : "#0000ff"}, styles.count]}>{this.props.count == 0 ? 'missing' : this.props.count}</Text>
          </View>
        </View>
      </TouchableOpacity>
    );
  }
}

class GridItem extends React.PureComponent {
  _onPress = () => {
    this.props.onPressItem(this.props.id);
  };

  render() {
    let item = this.props.item;
    return (
      <TouchableOpacity onPress={this._onPress} key={this.props.id}>
        <View style={[styles.gridItem]}>
          <Image
            source={item.image ? images[item.image] : require('./../images/empty-image.png')}
            style={{ width: 50, height: 50 }}
            resizeMode="contain"
          />
          <Text numberOfLines={1} style={styles.name}>{item.name}</Text>
          <Text numberOfLines={3} style={styles.description}>{item.description}</Text>
          <Text style={styles.price}>{item.price} $</Text>
          <Text style={[{backgroundColor: item.count == 0 ? "#ff0000" : "#0000ff"}, styles.count]}>{item.count == 0 ? 'missing' : item.count}</Text>
        </View>
      </TouchableOpacity>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    padding: 8,
    backgroundColor: "#ffffff",
  },
  rowContainer: {
    flexDirection: 'row',
    margin: 1
  },
  gridItem: {
    flex: 1,
    height: 190,
    margin: 5,
    justifyContent: 'center',
    alignItems: 'center',
  },
  listItem: {
    flex: 1,
    flexDirection: 'row',
    height: 130,
    margin: 1,
    marginTop: 5,
    marginBottom: 5,
    backgroundColor: "white"
  },
  listItemInfo: {
    flex: 1,
    flexDirection: 'column'
  },
  list: {
    flex: 1,
    alignItems: 'stretch',
  },
  name: {
    padding: 3,
    fontWeight: 'bold',
    flexWrap: "wrap",
    width: 100,
    textAlign: "center"
  },
  listName: {
    fontWeight: 'bold',
    flexWrap: "wrap",
    width: '80%',
  },
  description: {
    flex: 1,
    width: 80,
    flexWrap: "wrap",
    fontSize: 10
  },
  listDescription: {
    flex: 1,
    width: '80%',
    flexWrap: "wrap",
    fontSize: 10
  },
  price: {
    color: "#0000ff",
    paddingTop: 5,
    paddingBottom: 5,
  },
  count: {
    //backgroundColor: "#0000ff",
    width: '100%',
    textAlign: "center",
    color: "#ffffff"
  }
}); 