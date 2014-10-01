{*-------------------------------------------------------+
| Project 60 - Little BIC extension                      |
| Copyright (C) 2014                                     |
| Author: B. Endres (endres -at- systopia.de)            |
+--------------------------------------------------------+
| This program is released as free software under the    |
| Affero GPL license. You can redistribute it and/or     |
| modify it under the terms of this license which you    |
| can read by viewing the included agpl.txt or online    |
| at www.gnu.org/licenses/agpl.html. Removal of this     |
| copyright header is strictly prohibited without        |
| written permission from the original author(s).        |
+-------------------------------------------------------*}

{* TODO: make this more beatiful ;) *}
<table class="display" role="grid">
  <thead>
    <tr>
      <td><b>{ts}Country{/ts}</b></td>
      <td><b>{ts}Count{/ts}</b></td>
      <td><b>{ts}Actions{/ts}</b></td>
    </tr>
  </thead>


  <tbody>
{foreach from=$countries item=country}
    <tr>
      <td>{$country_names.$country}</td>
      <td><div name='number'>{$stats.$country}</div><img name='busy' src="{$config->resourceBase}i/loading.gif" hidden="1"/></td>
      <td style="text-align:right">
        <div class="action-link">
          <a class="button crm-extensions-refresh" id="new" onClick="update('{$country}', this);">
            <span><div class="icon refresh-icon"></div>{ts}Update{/ts}</span>
          </a>
        </div>
      </td>
    </tr>
{/foreach}
  </tbody>


  <tfoot>
    <tr>
      <td><b>{ts}Total{/ts}</b></td>
      <td><b><img name='busy' src="{$config->resourceBase}i/loading.gif" hidden="1"/><div name='number'>{$total_count}</div></b></td>
      <td>
        <div class="action-link">
          <a class="button crm-extensions-refresh" id="new" onClick="update('all', this);">
            <span><div class="icon refresh-icon"></div>{ts}Update All{/ts}</span>
          </a>
        </div>
      </td>
    </tr>
  </tfoot>
</table>


{literal}
<script type="text/javascript">
// general cleanup
cj("#printer-friendly").hide();
cj("#access").hide();

function update(country_code, button) {
  if (cj(button).hasClass('disabled')) {
    return;
  }
  
  if (country_code=='all') {
    // set ALL to busy
    cj('.button').addClass('disabled');
    cj(button).parent().parent().parent().parent().parent().find('[name="busy"]').show();
    cj(button).parent().parent().parent().parent().parent().find('[name="number"]').hide();
  } else {
    // set line to busy
    cj(button).addClass('disabled');
    cj(button).parent().parent().parent().find('[name="busy"]').show();
    cj(button).parent().parent().parent().find('[name="number"]').hide();
  }
  CRM.api3('Bic', 'update', {"country": country_code}).done(
    function(result) {
      // TODO: update _in table
      location.reload();
    });
}
</script>
{/literal}