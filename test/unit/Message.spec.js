//----------test-----------
//it is a test file for message sfc
//----------test-----------
//tasks:
//use vue test-utils
//mount sfc file
//test rendered HTML output of some component
//mount a component without rendering its child components


//include some lib
import { shallowMount } from '@vue/test-utils'
//include some file to test
import Message from '@/components/Message.vue'

describe('Message', () => {
  it('renders props.msg when passed', () => {
    const msg = 'new message'
    const wrapper = shallowMount(Message, {
      propsData: { msg }
    })
    //--for he is vue instance
    //wrapper is Vue instance?
    expect(wrapper.isVueInstance()).toBe(true)
    //check his 's name
    expect(wrapper.name()).toBe('message')
    //check his 's id
    expect(wrapper.attributes().id).toBe(undefined)
    //check his 's class
    expect(wrapper.classes('some name')).toBe(false)
    //check his 's content
    expect(wrapper.contains('h1')).toBe(true)
    expect(wrapper.html()).toBe(`<h1>${msg}</h1>`)
    expect(wrapper.text()).toBe(msg)
    //does not contain child node?
    expect(wrapper.isEmpty()).toBe(false)
    // has display: none or visibility: hidden style?
    expect(wrapper.isVisible()).toBe(true)
    //check his 's props value
    expect(wrapper.props()).toEqual({ msg: msg })
    expect(wrapper.props().msg).toBe(msg)
    expect(wrapper.props('msg')).toBe(msg)
  })

  it('renders default message if not passed a prop', () => {
    const defaultMessage = 'default message'
    const wrapper = shallowMount(Message)
    //--for he is vue instance
    //wrapper is Vue instance?
    expect(wrapper.isVueInstance()).toBe(true)
    //check his 's name
    expect(wrapper.name()).toBe('message')
    //check his 's id
    expect(wrapper.attributes().id).toBe(undefined)
    //check his 's class
    expect(wrapper.classes('some name')).toBe(false)
    //check his 's content
    expect(wrapper.contains('h1')).toBe(true)
    expect(wrapper.html()).toBe(`<h1>${defaultMessage}</h1>`)
    expect(wrapper.text()).toBe(defaultMessage)
    //does not contain child node?
    expect(wrapper.isEmpty()).toBe(false)
    // has display: none or visibility: hidden style?
    expect(wrapper.isVisible()).toBe(true)
    //check his 's props value
    expect(wrapper.props()).toEqual({ msg: undefined })
    expect(wrapper.props().msg).toBe(undefined)
    expect(wrapper.props('msg')).toBe(undefined)
  })
})
