import React from 'react';
import { StyleSheet, Text, View, Button, FlatList, TouchableOpacity } from 'react-native';
import { SearchBar, Icon } from 'react-native-elements';
import IconBadge from 'react-native-icon-badge';
import Grid from 'react-native-grid-component';
import appData from './../data';

export default class HomeScreen extends React.Component {
  constructor(props) {
    super(props);
    this.state = { cartCount: 5, isTabs: true, data: appData };
  }

  componentDidMount() {
    this.props.navigation.setParams({
      cartCount: this.state.cartCount,
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
        backgroundColor: '#f4511e',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
          <Icon
            reverse
            color='#517fa4'
            name={params.listView ? "view-list" : "dashboard"}
            type='material'
            onPress={() => params.toggleListView()}
          />

          <IconBadge
            MainElement={
              <Icon
                reverse
                color='#517fa4'
                name="shopping-cart"
                type='font-awesome'
                onPress={() => navigation.navigate('Cart')}
              />
            }
            BadgeElement={
              <Text style={{ color: '#FFFFFF' }}>{params.cartCount}</Text>
            }
            IconBadgeStyle={
              {
                width: 20,
                height: 20,
                backgroundColor: '#FF00EE'
              }
            }
            Hidden={params.cartCount === 0}
          />


        </View>
      ),
    };
  }

  renderGridItem = (data, i) => {
    const { navigate } = this.props.navigation;
    return (
      <View style={[{ backgroundColor: data }, styles.gridItem]} key={i}>
        <Button title="Go"
          onPress={() => navigate('Details', { name: 'Jane' })}>
        </Button>
      </View>
    )
  }

  renderListItem = ({data}) => {
    //const { navigate } = this.props.navigation;
    return (
        <Text>{data.name}</Text>
    )
  }

  _keyExtractor = (item, index) => item.id;

  renderListItem = ({item}) => (
    <ListItem
      id={item.id}
      onPressItem={this._onPressItem}
      title={item.name}
    />
  );

  _onPressItem = () => {
    alert('lol');
  };

  renderPlaceholder = i => <View style={styles.gridItem} key={i} />;

  render() {
    let isTabs = this.state.isTabs;
    let itemList;
    if (isTabs) {
      itemList = <Grid
        style={styles.list}
        renderItem={this.renderGridItem}
        renderPlaceholder={this.renderPlaceholder}
        data={['black', 'white', 'red', 'green', 'blue', 'orange', 'yellow', 'green']}
        itemsPerRow={3}
      />
    }
    else {
      itemList = <FlatList
        data={this.state.data}
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
  };

  render() {
    const textColor = 'black';
    return (
      <TouchableOpacity onPress={this._onPress}>
        <View>
          <Text style={{color: textColor}}>{this.props.title}</Text>
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
    height: 160,
    margin: 1
  },
  listItem: {
    flex: 1,
    height: 60,
    margin: 1
  },
  list: {
    flex: 1
  },
}); 