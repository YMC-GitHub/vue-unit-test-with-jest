//----------test-----------
//it is a test file for message-toggle sfc
//----------test-----------
//tasks:
//use vue test-utils
//mount sfc file
//test rendered HTML output of some component
//simulating User Interaction
//mount a component without rendering its child components

//include some lib
import { shallowMount, mount } from '@vue/test-utils'
import Vue from 'vue'
//include some file to test
import MessageToggle from '@/components/MessageToggle.vue'
import Message from '@/components/Message.vue'

describe('MessageToggle.vue', () => {
  const wrapper = mount(MessageToggle)
  //const wrapper = shallowMount(MessageToggle)
  beforeEach(() => {
    jest.resetAllMocks();
  });
  it('test message toggle sfc before button is clicked', () => {

    //get some wrapper  by wrapper.find()
    const button = wrapper.find('#toggle-message')
    //wrapper is Vue instance?
    expect(button.isVueInstance()).toBe(false)
    //check ele 's tag
    expect(button.is('button')).toBe(true)
    expect(button.name()).toBe('button')
    //check ele 's id
    expect(button.attributes().id).toBe('toggle-message')
    //check ele 's class
    expect(button.classes('some name')).toBe(false)
    //check ele 's content
    expect(button.contains('p')).toBe(false)
    expect(button.html('p')).toBe('<button id=\"toggle-message\">Change message</button>')
    expect(button.text()).toBe('Change message')
    //does not contain child node?
    expect(button.isEmpty()).toBe(false)
    // has display: none or visibility: hidden style?
    expect(button.isVisible()).toBe(true)
    //check ele 's event fire
    //wrapper.find('button').trigger('click');//fire dom event
    //wrapper.vm.$emit('click');//fire custom event

    const MessageSFC = wrapper.find(Message)
    // he exists?
    expect(MessageSFC.exists()).toBe(true)
    //wrapper is Vue instance?
    expect(MessageSFC.isVueInstance()).toBe(true)
    //check his 's name
    expect(MessageSFC.name()).toBe('message')
    //check his 's id
    expect(MessageSFC.attributes().id).toBe(undefined)
    //check his 's class
    expect(MessageSFC.classes('some name')).toBe(false)
    //check his 's content

    //shallowMount
    /*
    //check his 's content
    expect(MessageSFC.contains('h1')).toBe(false)
    expect(MessageSFC.html()).toBe('<message-stub></message-stub>')
    expect(MessageSFC.text()).toBe('')
    //does not contain child node?
    expect(MessageSFC.isEmpty()).toBe(true)
    // has display: none or visibility: hidden style?
    expect(MessageSFC.isVisible()).toBe(true)
    */

    //when mount
    expect(MessageSFC.contains('h1')).toBe(true)
    expect(MessageSFC.html()).toBe('<h1>default message</h1>')
    expect(MessageSFC.text()).toBe('default message')
    //does not contain child node?
    expect(MessageSFC.isEmpty()).toBe(false)
    // has display: none or visibility: hidden style?
    expect(MessageSFC.isVisible()).toBe(true)
    //check his 's props value
    expect(MessageSFC.props()).toEqual({ msg: null })
    expect(MessageSFC.props().msg).toBe(null)
    expect(MessageSFC.props('msg')).toBe(null)
    //MessageSFC.setProps({ msg: 'message' })
    //expect(MessageSFC.vm.msg).toBe('message')
    //check instance 's data
    expect(MessageSFC.vm.msg).toBe(null)
    //MessageSFC.setData({ msg: 'message' })
    //expect(MessageSFC.vm.msg).toBe('message')
    //check instance 's methord
    //expect(MessageSFC.props()).toEqual({ msg: 'message' })
  })
  /*
  it('toggles msg passed to Message when button is clicked with jest mock', () => {
    const mockFn = jest.fn();
    wrapper.setMethods({
      toggleMessage: mockFn
    });
    //fire his event click
    wrapper.find('button').trigger('click');
    //cancle his event click
    expect(mockFn).toBeCalled();
    expect(mockFn).toHaveBeenCalledTimes(1);
    wrapper.find('button').trigger('click');
    //cancle his event click
    expect(mockFn).toBeCalled();
    expect(mockFn).toHaveBeenCalledTimes(2);

  })
  */
  /*
  it('toggles msg passed to Message when button is clicked with Vue.nextTick', () => {
    //use Vue.nextTick()
    //get value from dom in fact
    //:ok
    //get some wrapper  by wrapper.find()
    const button = wrapper.find('#toggle-message')
    const MessageSFC = wrapper.find(Message)
    button.trigger('click');
    Vue.nextTick().then(function () {
      expect(MessageSFC.text()).toEqual('message')
      expect(MessageSFC.props()).toEqual({ msg: 'message' })
      expect(MessageSFC.vm.msg).toEqual('message')
      button.trigger('click');
      Vue.nextTick().then(function () {
        expect(MessageSFC.text()).toEqual('toggled message')
        expect(MessageSFC.props()).toEqual({ msg: 'toggled message' })
        expect(MessageSFC.vm.msg).toEqual('toggled message')
      })
    })
    //Vue.nextTick()
    //https://jestjs.io/docs/en/asynchronous#callbacks
    //or use flush-promises?

    //https://vue-test-utils.vuejs.org/guides/#getting-started
  })
  */

  it('toggles msg passed to Message when button is clicked with asnc/await', async () => {
    //use Vue.nextTick()
    //get value from dom in fact
    //:ok
    //get some wrapper  by wrapper.find()
    const button = wrapper.find('#toggle-message')
    const MessageSFC = wrapper.find(Message)
    button.trigger('click');
    await Vue.nextTick()
    expect(MessageSFC.text()).toEqual('message')
    expect(MessageSFC.props()).toEqual({ msg: 'message' })
    expect(MessageSFC.vm.msg).toEqual('message')
    button.trigger('click');
    await Vue.nextTick()
    expect(MessageSFC.text()).toEqual('toggled message')
    expect(MessageSFC.props()).toEqual({ msg: 'toggled message' })
    expect(MessageSFC.vm.msg).toEqual('toggled message')
    //Vue.nextTick()
    //https://jestjs.io/docs/en/asynchronous#callbacks
    //or use flush-promises?

    //https://vue-test-utils.vuejs.org/guides/#getting-started
  })

})
