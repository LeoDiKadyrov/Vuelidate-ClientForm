<template>
  <div id="app">
    <div class="container">
      <form class="client__form" @submit.prevent="submit">
        <h1 class="app__title">Client Form</h1>

        <!-- Main information -->
    <div class="main__block">
        <h3 class="component__title">Main information</h3>

        <div class="form-group" :class="{ 'form-group--error': $v.user.surname.$error }">
            <label class="form__label">Surname*</label>
            <input class="form__input" v-model.trim="$v.user.surname.$model" maxlength="30" />
        </div>
        <div class="error" v-if="$v.user.surname.$error && !$v.user.surname.required">Field is required</div>
        <div class="error" v-if="!$v.user.surname.minLength">Surname must have at least {{$v.user.surname.$params.minLength.min}} letters.</div>
        
        <div class="form-group" :class="{ 'form-group--error': $v.user.name.$error }">
            <label class="form__label">Name*</label>
            <input class="form__input" v-model.trim="$v.user.name.$model" maxlength="30"/>
        </div>
        <div class="error" v-if="$v.user.name.$error && !$v.user.name.required">Field is required</div>
        <div class="error" v-if="!$v.user.name.minLength">Name must have at least {{$v.user.name.$params.minLength.min}} letters.</div>

        <div class="form-group">
            <label class="form__label">Patronymic</label>
            <input class="form__input" maxlength="30" />
        </div>

        <div class="form-group" :class="{ 'form-group--error': $v.user.age.$error }">
            <label class="form__label">Age</label>
            <input class="form__input" v-model.trim.lazy="$v.user.age.$model"/>
        </div>
        <div class="error" v-if="$v.user.age.$error && !$v.user.age.required">Field is required</div>
        <div class="error" v-if="$v.user.age.$error && !$v.user.age.between">Must be between {{$v.user.age.$params.between.min}} and {{$v.user.age.$params.between.max}}</div>
        

        <div class="form-group" :class="{ 'form-group--error': $v.number.$error }">
            <label class="form__label">Phone number*</label>
            <input 
                  type="text"
                  :placeholder="template"
                  class="form__input"
                  v-model="number"
            >
        </div>
        <div class="error" v-if="$v.number.$error && !$v.number.required">Field is required</div>


        <div class="main__gender">
            <input type="radio" name="gender" value="male" /> Male
            <input type="radio" name="gender" value="female" /> Female
            <input type="radio" name="gender" value="other" /> Other 
        </div> <br>

    <div class="form-group" :class="{ 'form-group--error': !this.atLeastOne }">
        <label class="form__label">Client type*</label>
        <div class="main__clients">
            <div class="checkbox-container" v-for="(client) in user.clients" :key="client.name">
                <label class="checkbox-label">
                    <input 
                        type="checkbox" v-model="client.checked"   
                        :value="client.checked"
                        @change="isChecked(client)"
                    >
                    <span class="checkbox-custom"></span>
                </label>
                <div class="input-title">{{ client.name }}</div>
            </div>  
        </div>
    </div>
        <div class="error" v-if="!this.atLeastOne">Field is required</div>
        
            <div class="main__select">
                <select class="_select" required>
                    <option value="doc1">Иванов</option>
                    <option value="doc2">Захаров</option>
                    <option value="doc3">Чернышева</option>
                </select>
            </div>
    </div>

        <div id="sms-checkbox">
            <div class="checkbox-container">
                <label class="checkbox-label">
                    <input type="checkbox">
                    <span class="checkbox-custom"></span>
                </label>
                <div class="input-title">Не отправлять смс</div>
            </div>
        </div>

        <!-- Address information -->
        <div class="address__block main__block">
        <h3 class="component__title">Addres information</h3>

        <div class="form-group">
            <label class="form__label">Postcode</label>
            <input class="form__input" type="number" maxlength="30"/>
        </div>
        <CountryComponent></CountryComponent>

        <div class="form-group">
            <label class="form__label">Region</label>
            <input class="form__input" type="text" />
        </div>
        
        <div class="form-group" :class="{ 'form-group--error': $v.city.$error }">
            <label class="form__label">City*</label>
            <input class="form__input" v-model.trim="$v.city.$model" type="text" />
        </div>
        <div class="error" v-if="$v.city.$error && !$v.city.required">Field is required</div>

        <div class="form-group">
            <label class="form__label">Street</label>
            <input class="form__input" type="text" />
        </div>

        <div class="form-group">
            <label class="form__label">House</label>
            <input class="form__input" type="text" />
        </div>
    </div>


        <!-- Passport information -->
        <div class="passport__block main__block">
        <h3 class="component__title">Passport Information</h3>

        <div class="form-group">
            <label class="form__label">Type of document*</label>
            <div class="main__select">
                <select class="_select" required>
                    <option v-for="doc in docs" :key="doc">{{ doc }}</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="form__label">Series</label>
            <input class="form__input" type="text" />
        </div>  

        <div class="form-group">
            <label class="form__label">Number</label>
            <input class="form__input" type="text" />
        </div>

        <div class="form-group">
            <label class="form__label">Issued by</label>
            <input class="form__input" type="text" />
        </div>

        <div class="form-group" :class="{ 'form-group--error': $v.issueDate.$error }">
            <label class="form__label">Date of issue</label>
            <input class="form__input" v-model="$v.issueDate.$model" type="date" />
        </div>
        <div class="error" v-if="$v.issueDate.$error && !$v.issueDate.required">Field is required</div>
    </div>

        <!-- Submit button -->
        <div class="form__submit">
            <button 
            type="submit" 
            :disabled="submitStatus === 'PENDING'" 
            id="submit-button"
            >Submit!</button>
            <p v-if="submitStatus === 'OK'">New client has been created!</p>
            <p v-if="submitStatus === 'ERROR'">Please fill the form correctly.</p>
            <p v-if="submitStatus === 'PENDING'">Sending...</p>
        </div>

      </form>
    </div>
  </div>

</template>

<script>
import "./styles/styles.scss";
import CountryComponent from "./components/CountryComponent.vue"
import { required, minLength, between } from 'vuelidate/lib/validators' 
export default {
  name: 'App',
  data() {
    return {
      submitStatus: null,
      city: '',
      issueDate: '',
      docs: [null, "Паспорт", "Свидетельство о рождении", "Вод. удостоверение"],
      number: '',
      format: '',
      regex: '^',
      template: "+X(XXX) XXX-XXXX",
      atLeastOne: false,
      count: 0,
      user: {
          name: null,
          surname: null,
          age: null,
          clients: {
              vip: {
                  name: "VIP",
                  checked: false
              },
              problem: {
                  name: "Проблемные",
                  checked: false
              },
              oms: {
                  name: "ОМС",
                  checked: false
              }
          }
      }
    }
  },
  components: {
    CountryComponent
  },
  validations: {
        user: {
            name: {
                required,
                minLength: minLength(4)
            },
            surname: {
                required,
                minLength: minLength(4)
            },
            age: {
                required,
                between: between(18, 80)
            },
            clients: {
                required
            }
        },
        city: {
            required
        },
        issueDate: {
            required
        },
        number: {
            required
        }
    },
  methods: {
    submit() {
      this.$v.$touch()
      console.log("submit atleastone: ", this.atLeastOne)
      if (this.$v.$invalid && !this.atLeastOne) {
        this.submitStatus = 'ERROR'
      } 
      else if(!this.atLeastOne) {
          this.submitStatus = 'ERROR'
      }
      else {
        // do your submit logic here
        this.submitStatus = 'PENDING'
        setTimeout(() => {
          this.submitStatus = 'OK'
        }, 500)
      }
    },
    isChecked(client) {
        if (client.checked) { 
            this.count += 1;
        } else { this.count -= 1; }
        if (this.count == 0) {
            this.atLeastOne = false;
        } else { this.atLeastOne = true; }
    } 
  },
  mounted() {
    let x = 1;
    this.format = this.template.replace(/X+/g, () => '$' + x++);
    this.template.match(/X+/g).forEach((char) => {
        this.regex += '(\\d{' + char.length + '})?';
    })
  },
  watch: {
    number(next, prev) {
        if (next.length > prev.length) {
        this.number = this.number.replace(/[^0-9]/g, '')
            .replace(new RegExp(this.regex, 'g'), this.format)
            .substr(0, this.template.length);
        }
    }
  },
}
</script>

// to-do
// 1. sweet alert
// 2. checkbox required
// 3. selector required
// 4. form submission